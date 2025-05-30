#Es necesario agregar el remoto de core
#git remote add upstream https://git.libreoffice.org/core
set -x
# Repo folder to update: nightly-update
pushd nightly-update
git fetch --all --tags
git merge --abort
git reset --hard
git clean -df

git checkout -q -f origin/master

git fetch upstream master

DATE="$(date +%Y-%m-%d)"
git branch -D actualizacion-master-"$DATE"
git checkout -b actualizacion-master-"$DATE"
git merge --no-commit upstream/master


if [ "$?" -eq "0" ]; then
    #hacer push de rama
    git commit -a -m "actualizacion automatica $DATE"
    git push origin actualizacion-master-"$DATE"
else
    #enviar mensaje de log de error
    echo "ERR_BOT: No actualizO repositorio"
fi

popd