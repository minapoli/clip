#Aqueduct - Compliance Remediation Content
#Copyright (C) 2011,2012  Vincent C. Passaro (vincent.passaro@gmail.com)
#
#This program is free software; you can redistribute it and/or
#modify it under the terms of the GNU General Public License
#as published by the Free Software Foundation; either version 2
#of the License, or (at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program; if not, write to the Free Software
#Foundation, Inc., 51 Franklin Street, Fifth Floor,
#Boston, MA  02110-1301, USA.

#!/bin/bash
######################################################################
#By Tummy a.k.a Vincent C. Passaro		                     #
#Vincent[.]Passaro[@]gmail[.]com				     #
#www.vincentpassaro.com						     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
#
# Updated by Lee Kinser (lkinser@redhat.com) on 1 May 2012 to squash
# find errors

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-994
#Group Title: snmpd.conf permissions
#Rule ID: SV-994r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005320
#Rule Title: The snmpd.conf file must have mode 0600 or less permissive.
#
#Vulnerability Discussion: The snmpd.conf file contains authenticators and must be protected from unauthorized access and modification.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the mode of the SNMP daemon configuration file.
#
#Procedure:
#
#Examine the default install location /etc/snmp/snmpd.conf
#or:
# find / -name snmpd.conf
#
# ls -lL <snmpd.conf file>
#If the snmpd.conf file has a mode more permissive than 0600, this is a finding.
#
#Fix Text: Change the mode of the SNMP daemon configuration file to 0600.
#
#Procedure:
# chmod 0600 <snmpd.conf>   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005320
SNMPDFILES=$( find / -fstype nfs -prune -o -name snmpd.conf -print 2> /dev/null )
#Start-Lockdown

for line in $SNMPDFILES
  do
    if [ -a $line ]
    then

    # Pull the actual permissions
    FILEPERMS=`stat -L --format='%04a' $line`

    # Break the actual file octal permissions up per entity
    FILESPECIAL=${FILEPERMS:0:1}
    FILEOWNER=${FILEPERMS:1:1}
    FILEGROUP=${FILEPERMS:2:1}
    FILEOTHER=${FILEPERMS:3:1}

    # Run check by 'and'ing the unwanted mask(7137)
        if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&1)) != "0" ] || [ $(($FILEGROUP&7)) != "0" ] || [ $(($FILEOTHER&7)) != "0" ]
         then
          chmod u-xs,g-rwxs,o-rwxt $line
        fi
    fi
done
