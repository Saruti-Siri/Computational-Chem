#!/bin/bash

nodes=1
cores=5
mem=50
walltime=400
partition="normal"

if [ $# -lt 1 ]
then
  echo "Usage: $0 program_name [parameters]"
  echo "Parameters:"
  echo "-q partition (default - $partition)"
  echo "-n nodes (default - $nodes)"
  echo "-p cores (per node, default - $cores)"
  echo "-m memory (per node, in MB, default - $mem)"
  echo "-w time_limit (in hours, default - $time_limit)"
  echo "-i \"program_parameter1 program_parameter2 ...\" (list of program parameters)"
  exit 1
fi

param_err=0
unset program_name
unset p_param

until [ -z $1 ]
do
        if [ $1 = "-q" ]
        then
                partition="$2"
                shift; shift
        elif [ $1 = "-n" ]
        then
                nodes="$2"
                shift; shift
                if [ -n "`echo $nodes | grep '[^[:digit:]]'`" ]
                then
                        echo "Nodes value must be a number!"
                        param_err=1
                fi

        elif [ $1 = "-p" ]
        then
		echo $1, $2
                cores="$2"
                shift; shift
                if [ -n "`echo $cores | grep '[^[:digit:]]'`" ]
                then
                        echo "Cores value must be a number!"
                        param_err=1
                fi
        elif [ $1 = "-m" ]
        then
                mem=$2
                shift; shift
                if [ -n "`echo $mem | grep '[^[:digit:]]'`" ]
                then
                        echo "Memory size must be a number!"
                        param_err=1
                fi
        elif [ $1 = "-w" ]
        then
                walltime="$2"
                shift; shift
                if [ -n "`echo $walltime | grep '[^[:digit:]]'`" ]
                then
                        echo "Walltime must be a number!"
                        param_err=1
                fi
        elif [ $1 = "-i" ]
        then
                p_param=$2
                shift; shift
        elif [ -n "`echo $1 | grep ^-`" ]
        then
                echo "Unknown option: $1"
                param_err=1
	else
		if [ -z "$program_name" ]
                then
                        program_name=$1
                        shift
                else
                        echo "Unknown parameter: $1"
                        shift
                        param_err=1
                fi
        fi
done


if [ -z "$program_name" ]
then
        echo "There is no program name specification!"
        param_err=1
fi

nc=$(( $nodes * $cores ))


if [ $nc -ne "1" ]
then
        PARCH=MPI
fi

if [ $param_err -eq 1 ]
then
        exit 1
fi

program_f=$(basename "$program_name")
program_fname="${program_f%.*}"

WD=`pwd`

echo "The job is being submitted with the following parameters:"
echo
printf "\t%-12s %s\n" "p_param" "$p_param"
printf "\t%-12s %s\n" "partition" $partition
printf "\t%-12s %s\n" "nodes" $nodes
printf "\t%-12s %s (per node)\n" "cores" $cores
printf "\t%-12s %s GB (per node)\n" "memory" $mem
printf "\t%-12s %s hours\n" "walltime" $walltime
echo "If the job hangs, you may try to specify other values of nodes and cores"
echo

cat << EOF | sbatch
#!/bin/bash
#
#SBATCH -p $partition
#SBATCH -A hpc-andrunio-1716815712
#SBATCH -N $nodes 
#SBATCH -c $cores
#SBATCH --comment="software: TURBOMOLE_7.8"
#SBATCH --mem=10GB
#SBATCH -J ${program_fname:0:15}
#SBATCH -t $walltime:00:00

source /usr/local/sbin/modules.sh
module load turbomole/7.6

cd $WD

export PARA_ARCH=SMP
omp_threads=$SLURM_CPUS_PER_TASK
export OMP_NUM_THREADS=$omp_threads

export SCRATCH_DIR="/dev/shm/slurm/${SLURM_JOB_ID}"

echo \$SCRATCH_DIR

mkdir -p \$SCRATCH_DIR
export TURBOTMPDIR=\$SCRATCH_DIR
$program_name $p_param > $program_name.log

rm -rf \$SCRATCH_DIR
EOF

