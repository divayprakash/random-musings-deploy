#!/bin/sh.exe

echo
echo "Deployment started"
echo

rm -rf _site
echo
echo "STATUS - Deleted old _site folder"
echo


mkdir _site
cd _site
echo
echo "STATUS - Created new _site folder"
echo

echo
echo "Cloning deploy repo into _site folder"
echo
git clone https://github.com/divayprakash/random-musings-deploy.git . || { echo 'FAILURE - Cloning deploy repo failed!'; exit 1; }
echo
echo "SUCCESS - Cloned deploy repo into _site folder"
echo

cd ..
echo
echo "STATUS - Changed directory to root"
echo

echo
echo "STATUS - Reading last commit details"
echo
commit_details=$(git log -n 1 --pretty=format:"%h : \"%s\"")
echo
echo "STATUS - Last commit details - ${commit_details}"
echo

echo
echo "STATUS - Running Jekyll build"
echo
bundle exec jekyll build || { echo 'FAILURE - Build failed!'; exit 1; }
echo
echo "SUCCESS - Ran Jekyll build"
echo

cd _site/
echo
echo "STATUS - Directory changed to : $(pwd)"
echo

echo
echo "STATUS - Adding files to index of deploy repo"
echo
git add . || { echo "FAILURE - Adding files to index of deploy repo failed!"; exit 1; }
echo
echo "SUCCESS - Added files to index of deploy repo"
echo

echo
echo "STATUS - Creating commit in deploy repo"
echo
git commit -m "Deploy ${commit_details}" || { echo "FAILURE - Commit in deploy repo failed!"; exit 1; }
echo
echo "SUCCESS - Created commit in deploy repo"
echo

echo
echo "STATUS - Pushing to deploy repo"
echo
git push origin master || { echo "FAILURE - Push in deploy repo failed!"; exit 1; }
echo
echo "SUCCESS - Pushed to deploy repo"
echo

cd ..
echo
echo "STATUS - Changed directory to root"
echo

rm -rf _site
echo
echo "STATUS - Delete _site folder"
echo

echo
echo "Deployment successful!"
echo
