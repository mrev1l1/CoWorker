$(document).ready(function () {
    $('.selectpicker').selectpicker();
    $('.selectpicker').selectpicker({
        style: 'btn-info',
        size: 4
    });
});
window.onload = function () {
    
    $('.rm-mustard').click(function () {
        $('.remove-example').find('[value=Mustard]').remove();
        $('.remove-example').selectpicker('refresh');
    });
    $('.rm-ketchup').click(function () {
        $('.remove-example').find('[value=Ketchup]').remove();
        $('.remove-example').selectpicker('refresh');
    });
    $('.rm-relish').click(function () {
        $('.remove-example').find('[value=Relish]').remove();
        $('.remove-example').selectpicker('refresh');
    });
    $('.ex-disable').click(function () {
        $('.disable-example').prop('disabled', true);
        $('.disable-example').selectpicker('refresh');
    });
    $('.ex-enable').click(function () {
        $('.disable-example').prop('disabled', false);
        $('.disable-example').selectpicker('refresh');
    });


    // scrollYou
    $('.scrollMe .dropdown-menu').scrollyou();

    prettyPrint();
};

function getSelectedOptions()
{
    var oList = oForm.elements["job_category"];
    var sdValues = [];
    for(var i = 1; i < oList.options.length; i++)
    {
        if(oList.options[i].selected == true)
        {
            sdValues.push(oList.options[i].value);
        }
    }
    return sdValues;
}


var color = 'White'; 

function changeColor(obj) 
{ 
    var rowObject = getParentRow(obj); 
    var parentTable = 
      document.getElementById("<%=chkList.ClientID%>"); 

    if(color == '') 
    {
        color = getRowColor(); 
    } 

    if(obj.checked) 
    {
        rowObject.style.backgroundColor = '#A3B1D8'; 
    }
    else 
    {
        rowObject.style.backgroundColor = color; 
        color = 'White'; 
    }
}
    // private method
    function getRowColor() 
    {
        if(rowObject.style.backgroundColor == 'White')
            return parentTable.style.backgroundColor; 
        else return rowObject.style.backgroundColor; 
    }
}

// This method returns the parent row of the object
function getParentRow(obj) 
{ 
    do 
    {
        obj = obj.parentElement; 
    }
    while(obj.tagName != "TR") 
    return obj; 
}

function TurnCheckBoixGridView(id)
{
    var frm = document.forms[0];

    for (i=0;i<frm.elements.length;i++)
    {
        if (frm.elements[i].type == "checkbox" && 
            frm.elements[i].id.indexOf("<%= chkList.ClientID %>") == 0)
        {
            frm.elements[i].checked = 
              document.getElementById(id).checked;
        }
    }
}

function SelectAll(id)
{
    var parentTable = document.getElementById("<%=chkList.ClientID%>"); 
    var color

    if (document.getElementById(id).checked)
    {
        color = '#A3B1D8'
    }
    else
    {
        color = 'White'
    }

    for (i=0;i<parentTable.rows.length;i++)
    {
        parentTable.rows[i].style.backgroundColor = color;
    }
    TurnCheckBoixGridView(id);
}
