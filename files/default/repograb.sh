#!/bin/sh
#======================================================================
# download repos
#
# Prequisites to install:
# * yumutils (for reposync)
# * yum-plugin-fastestmirror
# * createrepo (and modifyrepo)
# * deltarpm
# * crudini
#======================================================================

# read in name of config file
repo_config=$1
# file=$(basename "${repo_config}")
# family="${file%.*}"

# path_base='/var/www/repos/latest'
# path_family="${path_base}/el7/${family}"
path_family=$2

#
# reposync
#  -l       to use fastmirror plugin
#  --source to grab *.src.rpm
#  -m       to download comps.xml
#  --download_metadata to get non-standard metadata
#
#  -c  specify a config file
#  -r  repo-id to sync
#  -p  directory to download to
#
cmd_reposync='reposync -l --source --download-metadata -m'

#
# createrepo
#  -p        to make xml output human readable
#  --update  to reuse existing metadata
#  --workers to speed things up with more threads
#
#  -g add comps.xml to repo data
#
cmd_createrepo='createrepo --update -p --workers 2'


#===================================
# Process all repos in config file
#===================================
repo_list=$(crudini --get --list ${repo_config})

printf '%s\n' "${repo_list}"| while IFS= read -r repo_id; do
  echo "---"
  echo "Repo: ${repo_id}"
  path_repo="${path_family}/${repo_id}"

  # Add retry on fail
  ${cmd_reposync} -c ${repo_config} -r ${repo_id} -p ${path_family}


  # Generate Repo MetaData
  if [ -f "${path_repo}/comps.xml" ]; then
    cp ${path_repo}/comps.xml ${path_repo}/Packages/
    ${cmd_createrepo} -g ${path_repo}/Packages/comps.xml ${path_repo}
  else
    ${cmd_createrepo} ${path_repo}
  fi

  # Add errata
  set -o pipefail
  updateinfo=$(ls -1t  ${path_repo}/*-updateinfo.xml.gz 2>/dev/null | head -1 )
  if [ -f $updateinfo  &&  $? -eq 0 ]; then
    echo "Updating errata information for ${path_repo}"
    #\cp $updateinfo ${path_repo}/updateinfo.xml.gz
    #gunzip -df ${path_repo}/updateinfo.xml.gz
    #modifyrepo ${path_repo}/updateinfo.xml ${path_repo}/repodata/
  else
    echo "No errata information to be processed for ${path_repo}"
  fi
done

exit 0
