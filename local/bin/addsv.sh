#!/bin/sh
#
# http://blog.hansode.org/
#
# $0 <service name>
#
# $ cd /service/
# $ sudo ./addsv.sh new-service
# edit .new-service/run...
# $ sudo mv -i .new-service new-service
# $ sudo svstat ./new-service

PATH=/bin:/usr/bin:/sbin:/usr/sbin
export PATH


#
# usage
#
usage() {
  cat <<EOS
usage:
  $0 <service name>

EOS
  exit 1
}



#
# main
#
[ $# = 1 ] || usage

svdir=/service
svname=$(basename $1)
acct_name=root
acct_group=adm

if [ ! -d ${svdir}  ]; then
    echo "missing $svdir"
    exit
fi
if [ -z ${svname} ]; then
    echo "$svname is already exists"
    exit
fi
[ -d ${svdir}/.${svname} ] && usage
id ${acct_name} 2>&1 >/dev/null || { echo "no such acct: ${acct_name}"; usage; }

# directory, file

mkdir    ${svdir}/.${svname}
chmod +t ${svdir}/.${svname}
mkdir    ${svdir}/.${svname}/env
mkdir    ${svdir}/.${svname}/log
mkdir    ${svdir}/.${svname}/log/main
touch    ${svdir}/.${svname}/log/status
chown ${acct_name}:${acct_group} ${svdir}/.${svname}/log/main
chown ${acct_name}:${acct_group} ${svdir}/.${svname}/log/status


# run script

cat <<EOS > ${svdir}/.${svname}/run
#!/bin/sh

PATH=/command:/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin
export PATH

exec 2>&1
exec setuidgid ${acct_name} \
    sleep 3

EOS
chmod +x ${svdir}/.${svname}/run


cat <<EOS > ${svdir}/.${svname}/log/run
#!/bin/sh
exec setuidgid ${acct_name} multilog t s1000000 n100 ./main
EOS

chmod +x ${svdir}/.${svname}/log/run


echo "done! .$svname created"

exit 0
