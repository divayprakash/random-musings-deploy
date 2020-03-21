#!/bin/sh.exe

echo
echo -e "\e[30;44m ------------------ \e[0m"
echo -e "\e[30;44m Deployment started \e[0m"
echo -e "\e[30;44m ------------------ \e[0m"
echo

echo
echo -e "\e[30;43m STATUS - Pushing to source repo  \e[0m"
echo
git push origin master || { echo -e "\e[30;41m FAILURE - Push to source repo failed! \e[0m"; exit 1; }
echo
echo -e "\e[30;42m SUCCESS - Pushed to source repo \e[0m"
echo

rm -rf _site
echo
echo -e "\e[30;43m STATUS - Deleted old _site folder \e[0m"
echo


mkdir _site
cd _site
echo
echo -e "\e[30;43m STATUS - Created new _site folder \e[0m"
echo

echo
echo -e "\e[30;43m STATUS - Cloning deploy repo into _site folder \e[0m"
echo
git clone --depth 1 https://github.com/divayprakash/random-musings-deploy.git . || { echo -e "\e[30;41m FAILURE - Cloning deploy repo failed! \e[0m"; exit 1; }
echo
echo -e "\e[30;42m SUCCESS - Cloned deploy repo into _site folder \e[0m"
echo

cd ..
echo
echo -e "\e[30;43m STATUS - Changed directory to root \e[0m"
echo

echo
echo -e "\e[30;43m STATUS - Reading last commit details \e[0m"
echo
commit_details=$(git log -n 1 --pretty=format:"%h : \"%s\"")
echo
echo -e "\e[30;43m STATUS - Last commit details - ${commit_details} \e[0m"
echo

echo
echo -e "\e[30;43m STATUS - Running Jekyll build \e[0m"
echo
bundle exec jekyll build || { echo -e "\e[30;41m FAILURE - Build failed! \e[0m"; exit 1; }
echo
echo -e "\e[30;42m SUCCESS - Ran Jekyll build \e[0m"
echo

cd _site/
echo
echo -e "\e[30;43m STATUS - Directory changed to : $(pwd) \e[0m"
echo

echo
echo -e "\e[30;43m STATUS - Adding files to index of deploy repo \e[0m"
echo
git add . || { echo -e "\e[30;41m FAILURE - Adding files to index of deploy repo failed! \e[0m"; exit 1; }
echo
echo -e "\e[30;42m SUCCESS - Added files to index of deploy repo \e[0m"
echo

echo
echo -e "\e[30;43m STATUS - Creating commit in deploy repo \e[0m"
echo
git commit -m "Deploy ${commit_details}" || { echo -e "\e[30;41m FAILURE - Commit in deploy repo failed! \e[0m"; exit 1; }
echo
echo -e "\e[30;42m SUCCESS - Created commit in deploy repo \e[0m"
echo

echo
echo -e "\e[30;43m STATUS - Pushing to deploy repo \e[0m"
echo
git push origin master || { echo -e "\e[30;41m FAILURE - Push to deploy repo failed! \e[0m"; exit 1; }
echo
echo -e "\e[30;42m SUCCESS - Pushed to deploy repo \e[0m"
echo

cd ..
echo
echo -e "\e[30;43m STATUS - Changed directory to root \e[0m"
echo

rm -rf _site
echo
echo -e "\e[30;43m STATUS - Delete _site folder \e[0m"
echo

echo
echo -e "\e[30;44m ---------------------- \e[0m"
echo -e "\e[30;44m Deployment successful! \e[0m"
echo -e "\e[30;44m ---------------------- \e[0m"
echo

notify-send -i info -t 10000 "Random Musings" "Blog deployment successful!"
