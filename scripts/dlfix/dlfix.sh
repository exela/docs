function dlfix() {
  echo "Select the Portal Version."
  echo ""
  select portalversion in 7010 7110 7210 7310
  do
    case $portalversion in
      7010)
        echo ""
        echo "You have selected " $portalversion"."
        portaldir=7.0.10
        echo ""
        break
        ;;
      7110)
        echo ""
        echo "You have selected " $portalversion"."
        portaldir=7.1.10
        echo ""
        break
        ;;
      7210)
        echo ""
        echo "You have selected " $portalversion"."
        echo ""
        portaldir=7.2.10
        break
        ;;
      7310)
        echo ""
        echo "You have selected " $portalversion"."
        echo ""
        portaldir=7.3.10
        break
        ;;
      *)
        echo ""
        echo "Invalid selection. Please try again."
        break
        quit
        ;;
    esac
  done
  
  # Defining DL Functions for Hotfixes
  function dlhotfix() {
    echo ""
    echo "What Patch Number? "
    read patchnumber
    echo ""
    echo ""
    if [ -d ./patching-tool ]; then
      cd ./patching-tool/patches
      curl -n -a -O -v http://files.liferay.com/private/ee/fix-packs/$portaldir/hotfix/liferay-hotfix-$patchnumber-$portalversion.zip
      cd -
      echo ""
      echo "Downloaded liferay-hotfix-"$patchnumber-$portalversion".zip"
      echo ""
    elif [ -d ./patches ]; then
      cd ./patches
      curl -n -a -O -v http://files.liferay.com/private/ee/fix-packs/$portaldir/hotfix/liferay-hotfix-$patchnumber-$portalversion.zip
      cd -
      echo ""
      echo "Downloaded liferay-hotfix-"$patchnumber-$portalversion".zip"
      echo ""
    else
      echo ""
      echo "Please make sure that you are in a Liferay Directory!"
      fi
  }

  # Defining DL Functions for Fix Packs
  function dlfixpack() {
    echo ""
    echo "What Patch Number? "
    read patchnumber
    if [ -d ./patching-tool ] && [ $portalversion = 7010 ]; then
      cd ./patching-tool/patches
      curl -n -a -O -v http://files.liferay.com/private/ee/fix-packs/$portaldir/de/liferay-fix-pack-de-$patchnumber-$portalversion.zip
      cd -
      echo ""
      echo "Downloaded liferay-fix-pack-de-"$patchnumber-$portalversion".zip"
      echo ""
    elif [ -d ./patching-tool ] && [ $portalversion != 7010 ]; then
      cd ./patching-tool/patches
      curl -n -a -O -v http://files.liferay.com/private/ee/fix-packs/$portaldir/dxp/liferay-fix-pack-dxp-$patchnumber-$portalversion.zip
      cd -
      echo ""
      echo "Downloaded liferay-fix-pack-dxp-"$patchnumber-$portalversion".zip"
      echo ""
    elif [ -d ./patches ] && [ $portalversion = 7010 ]; then
      cd ./patches
      curl -n -a -O -v http://files.liferay.com/private/ee/fix-packs/$portaldir/de/liferay-fix-pack-$patchnumber-$portalversion.zip
      cd -
      echo ""
      echo "Downloaded liferay-fix-pack-de-"$patchnumber-$portalversion".zip"
      echo ""
    elif [ -d ./patches ] && [ $portalversion != 7010 ]; then
      cd ./patches
      curl -n -a -O -v http://files.liferay.com/private/ee/fix-packs/$portaldir/dxp/liferay-fix-pack-$patchnumber-$portalversion.zip
      cd -
      echo ""
      echo "Downloaded liferay-fix-pack-dxp-"$patchnumber-$portalversion".zip"
      echo ""
    else
      echo ""
      echo "Please make sure that you are in a Liferay Directory!"
    fi
  }


  # Select Hotfix or Fixpack
  select fixtype in Hotfix Fixpack
	do
		case $fixtype in
			Hotfix) dlhotfix
      break
			;;
			Fixpack) dlfixpack
      break
        ;;
			*)
        echo ""
        echo "Please select Hotfix or Fixpack."
        break
			;;
    esac
  done
}