#!/bin/bash
  
mail_content=""

parse_done=false

subject="Default Subject Here"
from="Default From <default@example.com>"
to="$1" # Address where mail will be delivered
mailgun_api_key="$2"
mailgun_domain="$3"

while IFS= read -r line; do
        if [ "$line" = "" ]; then
                parse_done=true
        else
                if [ "$parse_done" == true ]; then
                        mail_content="$mail_content$line\n"
                else
                        if [[ $line == Subject:* ]]; then
                                subject=${line#"Subject: "}
                        fi

                        if [[ $line == From* ]]; then
                                from=${line#"From: "}
                        fi
                fi
        fi
done

echo -e $mail_content | curl -s --user "$mailgun_api_key" https://api.mailgun.net/v3/"$mailgun_domain"/messages -F from="$from" -F to="$to" -F subject="$subject" -F text="<-"
