#!/bin/bash
echo "<!DOCTYPE html>"
echo "<html>"
echo "<head>"
echo "	<meta http-equiv="Content-type" content="text/html;charset=UTF-8" />"
echo "</head>"
echo "<body>"
while IFS= read LINE
do
	if echo "$LINE" | grep -E '^$' > /dev/null
	then
		LINE="<p>"
		
	fi

	if echo "$LINE" | grep -E '^# '> /dev/null
	then
		LINE=$(echo "$LINE" | sed 's/^# \(.*\)$/<h1>\1<\/h1>/')  
	fi

	if echo "$LINE" | grep -E '^## '> /dev/null
	then
		LINE=$(echo "$LINE" | sed 's/^## \(.*\)$/<h2>\1<\/h2>/')
	fi

	if echo "$LINE" | grep -E '__.*__'> /dev/null
	then
		LINE=$(echo "$LINE" | sed 's/__\([^_]*\)__/<strong>\1<\/strong>/g')
	fi

	if echo "$LINE" | grep -E '_.*_'> /dev/null
        then
                LINE=$(echo "$LINE" | sed 's/_\([^_]*\)_/<em>\1<\/em>/g')
        fi
	
	
	if echo "$LINE" | grep -E '<https://.*'> /dev/null
        then
		LINE=$(echo "$LINE" | sed 's/<\(.*\)>/<a href=\1>https:\/\/google.sk\/<\/a>/')
        fi

	if echo "$LINE" | grep -E '^ - ' > /dev/null
        then
                 echo "<ol>"

		 while IFS= read ZOZ
		 do
			if echo "$ZOZ" | grep -E '^ - '> /dev/null
			then
				ZOZ=$(echo "$ZOZ" | sed 's/ - \(.*\)$/<li>\1<\/li>/')

			elif echo "$ZOZ" | grep '^[^ ]'> /dev/null
			then
				break 
			fi
			echo "$ZOZ"
		 done
		 echo "</ol>" 
	fi


	echo "$LINE"
done
echo "</body>"
echo "</html>"
