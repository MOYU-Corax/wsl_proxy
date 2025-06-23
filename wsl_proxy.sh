#!/bin/sh
hostip=$(cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }')
wslip=$(hostname -I | awk '{print $1}')
port=7897
 
PROXY_HTTP="http://${hostip}:${port}"
 
set_proxy(){
  echo "Host ip is:${hostip}"
  echo "WSL ip is:${wslip}"
  
  export http_proxy="${PROXY_HTTP}"
  export HTTP_PROXY="${PROXY_HTTP}"
 
  export https_proxy="${PROXY_HTTP}"
  export HTTPS_PROXY="${PROXY_HTTP}"
 
  export ALL_PROXY="${PROXY_SOCKS5}"
  export all_proxy=${PROXY_SOCKS5}
  # git proxy
  git config --global http.https://github.com.proxy ${PROXY_HTTP}
  git config --global https.https://github.com.proxy ${PROXY_HTTP}
  # apt proxy
  sudo sh -c "echo \
'Acquire {
   http::Proxy \"${PROXY_HTTP}\";
   https::Proxy \"${PROXY_HTTP}\";
}' > /etc/apt/apt.conf.d/proxy.conf"
 
  echo "Proxy has been opened."
  test_setting
}
 
unset_proxy(){
  unset http_proxy
  unset HTTP_PROXY
  unset https_proxy
  unset HTTPS_PROXY
  unset ALL_PROXY
  unset all_proxy
  # git proxy
  git config --global --unset http.https://github.com.proxy
  git config --global --unset https.https://github.com.proxy
  # apt proxy
  sudo sh -c "echo "" >  /etc/apt/apt.conf.d/proxy.conf"
   
  echo "Proxy has been closed."
}
 
test_setting(){
  echo "Try to connect to Google..."
  resp=$(curl -I -s --connect-timeout 5 -m 5 -w "%{http_code}" -o /dev/null www.google.com)
  if [ ${resp} = 200 ]; then
    echo "Proxy setup succeeded!"
  else
    echo "Proxy setup failed!"
  fi
}
 
if [ "$1" = "set" ]
then
  set_proxy
 
elif [ "$1" = "off" ]
then
  unset_proxy
 
elif [ "$1" = "test" ]
then
  test_setting
else
  echo "Unsupported arguments."
fi
