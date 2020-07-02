#Simple Auto TCP DUMP And Discord Webhook Attack Detection

interface=ens3
dumpdir=/root/
capturefile=/root/output.txt
 url='https://discordapp.com/api/webhooks/712846455403970622/pG02eqUwLTT8-Lc2FhS3RxmZqVvcVhS-cnFrWmZYQHPFs9Ca44WTEdG0HEMrFRf-vcqF'
while /bin/true; do
  pkt_old=`grep $interface: /proc/net/dev | cut -d :  -f2 | awk '{ print $2 }'`
  sleep 1
  pkt_new=`grep $interface: /proc/net/dev | cut -d :  -f2 | awk '{ print $2 }'`
 
  pkt=$(( $pkt_new - $pkt_old ))
  echo -ne "\r$pkt packets/s\033[0K"
 
  if [ $pkt -gt 5000 ]; then
    echo "\nD\nD\no\nS\n Detected lmao"
    tcpdump -n -s0 -c 5000 -w $dumpdir/dump.`date +"%H%M"`.cap
    tshark -i - < "$dumpdir/dump.`date +"%H%M"`.cap" > "output.txt"
    curl -H "Content-Type: application/json" -X POST -d '{
      "embeds": [{
      	"inline": false,
        "title": "Attack Detected!",
        "username": "BeatZ Attack Alert",
        "color": 3066993,
         "thumbnail": {
          "url": "https://cdn.discordapp.com/attachments/711655132898787491/712862382988328980/United-States.png"
        },
         "footer": {
            "text": "BeatZ Detection",
            "icon_url": "https://cdn10.bigcommerce.com/s-raqyrv37/products/116/images/617/red_colored_sand__11015.1455040403.1280.850.jpg?c=2"
          },
    
        "description": "Chicago Server Is Being Attacked!",

         "fields": [
      {
        "name": "***Server Provider***",
        "value": "``Vultr``",
        "inline": false
      },
      {
        "name": "***Alert Type***",
        "value": "``Under Attack``",
        "inline": false
      },
      {
        "name": "***Location***",
        "value": ":flag_us: ``Illinios, Chicago``",
        "inline": false
      }
    ]
      }]
    }' $url
    echo "Paused for."
    sleep 120
    curl -H "Content-Type: application/json" -X POST -d '{
      "embeds": [{
      	"inline": false,
        "title": "Attack Finished!",
        "username": "BeatZ Attack Alert",
        "color": 3066993,
         "thumbnail": {
          "url": "https://cdn.discordapp.com/attachments/711655132898787491/712862382988328980/United-States.png"
        },
         "footer": {
            "text": "BeatZ Detection",
            "icon_url": "https://cdn10.bigcommerce.com/s-raqyrv37/products/116/images/617/red_colored_sand__11015.1455040403.1280.850.jpg?c=2"
          },
    
        "description": "Attack Has FInished On Chicago Server!",

         "fields": [
      {
        "name": "***Server Provider***",
        "value": "``Vultr``",
        "inline": false
      },
      {
        "name": "***Alert Type***",
        "value": "``Attack Finished``",
        "inline": false
      },
      {
        "name": "***Location***",
        "value": ":flag_us: ``Illinios, Chicago``",
        "inline": false
      }
    ]
      }]
    }' $url
  fi
done
