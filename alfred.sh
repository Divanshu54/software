#!/bin/bash

# DISCLAIMER
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# INITIALIZATION ##############################################################
set -o xtrace

debug=true

updateSystem=false
packages=""
repos=()
taskNames=()
taskMessages=()
taskDescriptions=()
taskRecipes=()
taskPostInstallations=()




# TASK LIST ###################################################################
#------------------------------------------------------------------------------
taskNames+=("Update system")
taskMessages+=("Updating system")
taskDescriptions+=("Install the latest version of all your software")
taskRecipes+=("updateSystem")
taskPostInstallations+=("")
taskSelectedList+=("FALSE")

updateSystem()
{
  updateSystem=true
}
#------------------------------------------------------------------------------
taskNames+=("Install automatic drivers")
taskMessages+=("Processing drivers")
taskDescriptions+=("Install drivers that are appropriate for automatic installation")
taskPostInstallations+=("")
taskRecipes+=("autoInstallDrivers")
taskSelectedList+=("FALSE")

autoInstallDrivers()
{
  ubuntu-drivers autoinstall
}
#------------------------------------------------------------------------------
taskNames+=("Install Java, Flash and codecs")
taskMessages+=("Processing Java, Flash and codecs")
taskDescriptions+=("Install non-open-source packages like Java, Flash plugin, Unrar, and some audio and video codecs like MP3/AVI/MPEG")
taskRecipes+=("installRestrictedExtras")
taskPostInstallations+=("")
taskSelectedList+=("FALSE")

installRestrictedExtras()
{
  addPackage "ubuntu-restricted-extras"
}
#------------------------------------------------------------------------------
taskNames+=("Install Chrome")
taskMessages+=("Processing Chrome")
taskDescriptions+=("The web browser from Google")
taskRecipes+=("installChrome")
taskPostInstallations+=("")
taskSelectedList+=("FALSE")

installChrome()
{
  if [[ $OSarch == "x86_64" ]]; then
      installPackage "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
  else
      >&2 echo "Your system is not supported by Google Chrome"
      return 1
  fi
}
#------------------------------------------------------------------------------
taskNames+=("Install Chromium")
taskMessages+=("Processing Chromium")
taskDescriptions+=("The open-source web browser providing the code for Google Chrome.")
taskRecipes+=("installChromium")
taskPostInstallations+=("")
taskSelectedList+=("FALSE")

installChromium()
{
  echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
  addPackage "chromium-browser"
}
#------------------------------------------------------------------------------
taskNames+=("Install Firefox")
taskMessages+=("Processing Firefox")
taskDescriptions+=("The web browser from Mozilla")
taskRecipes+=("installFirefox")
taskPostInstallations+=("")
taskSelectedList+=("FALSE")

installFirefox()
{
  addRepo "ppa:ubuntu-mozilla-security/ppa"
  addPackage "firefox firefox-locale-$(locale | grep LANGUAGE | cut -d= -f2 | cut -d_ -f1)"
}
#------------------------------------------------------------------------------
taskNames+=("Install Opera")
taskMessages+=("Processing Opera")
taskDescriptions+=("Just another web browser")
taskRecipes+=("installOpera")
taskPostInstallations+=("")
taskSelectedList+=("FALSE")

installOpera()
{
  echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
  echo opera-stable opera-stable/add-deb-source boolean true | debconf-set-selections

  if [[ $OSarch == "x86_64" ]]; then
    wget -O /tmp/opera.deb "https://download1.operacdn.com/pub/opera/desktop/52.0.2871.40/linux/opera-stable_52.0.2871.40_amd64.deb"
  else
    wget -O /tmp/opera.deb "https://download1.operacdn.com/pub/opera/desktop/52.0.2871.40/linux/opera-stable_52.0.2871.40_i386.deb"
  fi
  
  DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/opera.deb # Needs dpkg and variable set to avoid prompt
  rm /tmp/opera.deb
}
#------------------------------------------------------------------------------
taskNames+=("forticlient")
taskMessages+=("Processing forticlient")
taskDescriptions+=("flipkart VPN")
taskRecipes+=("installforticlient")
taskPostInstallations+=("")
taskSelectedList+=("FALSE")

installforticlient()
{
if [[ $OSarch == "x86_64" ]]; then
       wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1C-xW4ZAQX30LaEUfeQ24hOYdyUaj2j7K' -O forticlientsslvpn_linux_4.4.2331.tar.gz
else
wget -O - https://github.com/Divanshu54/ubuntusoftwaredeb/raw/main/forticlient-sslvpn_4.4.2333-1_86.deb
 fi
tar xvzf forticlientsslvpn_linux_4.4.2331.tar.gz
fi
}

      exit 0
    fi
fi

exit 0
