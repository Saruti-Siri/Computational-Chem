#Jest to skrypt, ktory przesuwa srodek masy do srodka ukladu wspolrzednych
#a nastepnie obraca czasteczke tak,
#ze jej tensor momentu bezwladnosci jest diagonalny
#This script moves the center of mass to the origin of coordinate system
#and then rotates the molecule so that its moment of inertia tensor is diagonal

package require Orient
namespace import Orient::orient
package provide vexpr

#Translate   
set sel [atomselect top "all"]
set com [measure center $sel weight mass]
set com_1 [vecscale -1 $com]
$sel moveby $com_1

#Rotations
set I [draw principalaxes $sel]
set A [orient $sel [lindex $I 2] {0 0 1}]
$sel move $A
set I [draw principalaxes $sel]
set A [orient $sel [lindex $I 1] {0 1 0}]
$sel move $A
set I [draw principalaxes $sel]

#Saving new coordinates

proc get_basename {molid} {
    set molname "[molinfo $molid get name]"
    set dotidx [string first . "$molname"]
    return [string range "$molname" 0 [expr $dotidx - 1]]
}
set output [format "%s-oriented.xyz" [get_basename top]]
$sel writexyz $output


quit

