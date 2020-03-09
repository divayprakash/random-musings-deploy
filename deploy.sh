#!/bin/sh.exe

echo
echo -e "\e[30;43;mDeployment started \e[0m"
echo

echo
echo -e "\e[30;43;mSTATUS - Pushing to source repo  \e[0m"
echo
git push origin master || { echo -e "\e[30;101;mFAILURE - Push to source repo failed! \e[0m"; exit 1; }
echo
echo -e "\e[30;42;mSUCCESS - Pushed to source repo \e[0m"
echo

rm -rf _site
echo
echo -e "\e[30;43;mSTATUS - Deleted old _site folder \e[0m"
echo


mkdir _site
cd _site
echo
echo -e "\e[30;43;mSTATUS - Created new _site folder \e[0m"
echo

echo
echo -e "\e[30;43;mSTATUS - Cloning deploy repo into _site folder \e[0m"
echo
git clone --depth 1 https://github.com/divayprakash/random-musings-deploy.git . || { echo -e "\e[30;101;mFAILURE - Cloning deploy repo failed! \e[0m"; exit 1; }
echo
echo -e "\e[30;42;mSUCCESS - Cloned deploy repo into _site folder \e[0m"
echo

cd ..
echo
echo -e "\e[30;43;mSTATUS - Changed directory to root \e[0m"
echo

echo
echo -e "\e[30;43;mSTATUS - Reading last commit details \e[0m"
echo
commit_details=$(git log -n 1 --pretty=format:"%h : \"%s\"")
echo
echo -e "\e[30;43;mSTATUS - Last commit details - ${commit_details} \e[0m"
echo

echo
echo -e "\e[30;43;mSTATUS - Running Jekyll build \e[0m"
echo
bundle exec jekyll build || { echo -e "\e[30;101;mFAILURE - Build failed! \e[0m"; exit 1; }
echo
echo -e "\e[30;42;mSUCCESS - Ran Jekyll build \e[0m"
echo

cd _site/
echo
echo -e "\e[30;43;mSTATUS - Directory changed to : $(pwd) \e[0m"
echo

echo
echo -e "\e[30;43;mSTATUS - Adding files to index of deploy repo \e[0m"
echo
git add . || { echo -e "\e[30;101;mFAILURE - Adding files to index of deploy repo failed! \e[0m"; exit 1; }
echo
echo -e "\e[30;42;mSUCCESS - Added files to index of deploy repo \e[0m"
echo

echo
echo -e "\e[30;43;mSTATUS - Creating commit in deploy repo \e[0m"
echo
git commit -m "Deploy ${commit_details}" || { echo -e "\e[30;101;mFAILURE - Commit in deploy repo failed! \e[0m"; exit 1; }
echo
echo -e "\e[30;42;mSUCCESS - Created commit in deploy repo \e[0m"
echo

echo
echo -e "\e[30;43;mSTATUS - Pushing to deploy repo \e[0m"
echo
git push origin master || { echo -e "\e[30;101;mFAILURE - Push to deploy repo failed! \e[0m"; exit 1; }
echo
echo -e "\e[30;42;mSUCCESS - Pushed to deploy repo \e[0m"
echo

cd ..
echo
echo -e "\e[30;43;mSTATUS - Changed directory to root \e[0m"
echo

rm -rf _site
echo
echo -e "\e[30;43;mSTATUS - Delete _site folder \e[0m"
echo

echo
echo -e "\e[30;42;mDeployment successful! \e[0m"
echo
