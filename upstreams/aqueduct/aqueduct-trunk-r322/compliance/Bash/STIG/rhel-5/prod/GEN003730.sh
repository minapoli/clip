#!/bin/bash

##########################################################################
#Aqueduct - Compliance Remediation Content
#Copyright (C) 2011,2012  
#  Vincent C. Passaro (vincent.passaro@gmail.com)
#  Shannon Mitchell (shannon.mitchell@fusiontechnology-llc.com)
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
##########################################################################

###################### Fotis Networks LLC ###############################
# By Vincent C. Passaro                                                 #
# Fotis Networks LLC	                                                #
# Vincent[.]Passaro[@]fotisnetworks[.]com                               #
# www.fotisnetworks.com	                                                #
###################### Fotis Networks LLC ###############################
#
#  _____________________________________________________________________
# |  Version |   Change Information  |      Author        |    Date    |
# |__________|_______________________|____________________|____________|
# |    1.0   |   Initial Script      | Vincent C. Passaro | 1-Aug-2012 |
# |          |   Creation            |                    |            |
# |__________|_______________________|____________________|____________|
#	                                                                  
   
	
#######################DISA INFORMATION##################################
# Group ID (Vulid): V-22423
# Group Title: GEN003730
# Rule ID: SV-37407r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003730
# Rule Title: The inetd.conf file, xinetd.conf file, and the xinetd.d 
# directory must be group-owned by root, bin, sys, or system.
#
# Vulnerability Discussion: Failure to give ownership of sensitive files 
# or utilities to system groups may provide unauthorized users with the 
# potential to access sensitive information or change the system 
# configuration possibly weakening the system's security posture.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the group ownership of the xinetd configuration files and 
# directories.

# Procedure:
# ls -alL /etc/xinetd.conf /etc/xinetd.d

# If a file or directory is not group-owned by root, bin, sys, or system, 
# this is a finding.


#
# Fix Text: 
#
# Change the group-owner of the xinetd configuration files and 
# directories.

# Procedure:
# chgrp -R root /etc/xinetd.conf /etc/xinetd.d     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003730
	
# Start-Lockdown

find /etc/xinetd.conf /etc/xinetd.d/ ! -group root ! -group bin ! -group sys -exec chgrp root {} \; 2> /dev/null