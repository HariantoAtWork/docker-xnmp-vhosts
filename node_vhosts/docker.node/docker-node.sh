SCRIPT_PATH=`pwd`/$BASH_SOURCE
ROOT_DIR=`dirname $SCRIPT_PATH`
DOCKER_XNMP_VHOSTS_ROOT=$ROOT_DIR/../..
DOCKER_PS_NAME=docker-node
SOCK=$DOCKER_XNMP_VHOSTS_ROOT/tmp/$DOCKER_PS_NAME.sock

docker rm -f $DOCKER_PS_NAME

docker pull harianto/api-sylo-space
docker run -v $DOCKER_XNMP_VHOSTS_ROOT/tmp:/tmp -v $ROOT_DIR/data:/home/node/app/src/data --restart always --name $DOCKER_PS_NAME -e GID='33' -e UID='33' -e "PORT=/tmp/$DOCKER_PS_NAME.sock" -dit harianto/api-sylo-space

# rm $SOCK; touch $SOCK; chmod 777 $SOCK && chown www-data:www-data $SOCK
# sleep 20
# chmod 777 $SOCK
echo DONE.