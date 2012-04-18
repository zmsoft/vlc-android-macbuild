#! /bin/sh

if [ -z "$BILI_VLC_TARGET" ]; then
    echo "_do_pull.sh is not supposed been executed directly"
    echo "execute _pull_xxx.sh instead"
    exit 1
fi

BILI_VLC_ANDROID_HASH=64063bd792
echo "pull "${BILI_VLC_TARGET}":"${BILI_VLC_ANDROID_HASH}

if [ ! -d ${BILI_VLC_TARGET} ]; then
    echo "vlc-ports/android source not found, cloning"
    git clone git://git.videolan.org/vlc-ports/android ${BILI_VLC_TARGET}
    cd ${BILI_VLC_TARGET}   
    git checkout -B bili ${BILI_VLC_ANDROID_HASH}
    cd -
else
    echo "vlc-ports/android source found, pulling from remote master"
    cd ${BILI_VLC_TARGET}
    git fetch origin
    git checkout -B bili ${BILI_VLC_ANDROID_HASH}    
    cd -
fi

echo "patch "${BILI_VLC_TARGET}
cd ${BILI_VLC_TARGET}
git am ../patches/ports-android/${BILI_VLC_TARGET}/*.patch || git am --abort
git am ../patches/ports-android/*.patch || git am --abort
cd -