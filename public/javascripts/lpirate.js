function friend_name_key_on_change()
{
	name_key = document.getElementById("friend_name_key");
	if(name_key.getValue() != "")
	{
		friend_name_node_array = document.getElementById("friend_box_select").getChildNodes();
		for(i = 0 ; i < friend_name_node_array.length ; i++ )
		{
		if(remove_html_tag(friend_name_node_array[i].getInnerHTML()).indexOf(name_key.getValue()) < 0)
			friend_name_node_array[i].setStyle("display",'none');
		else
			friend_name_node_array[i].setStyle("display",'block');
		}
	}
	else
		friend_show_all();
}
function friend_show_all()
{
	friend_name_node_array = document.getElementById("friend_box_select").getChildNodes();
	for(i = 0 ; i < friend_name_node_array.length ; i++ )
	{
		friend_name_node_array[i].setStyle("display",'block');
	}
}
function remove_html_tag(html)
{
	  html = html.replace(/<.*?>/g,"");
	  return html;
}