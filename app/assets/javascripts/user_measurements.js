    $( document ).ready(function() 
    {
        //request='<%= @graphsRequest %>';
        //alert(wt.measurements);
        console.log(wt.measurements);
        //jsDebug(request);
        //getResult=$.ajax({url: request, dataType: 'json', async: false});
        //if (getResult.status=='200')
        if (wt.measurements)
        {
            var aValues  = [];
            var aLabels = [];
            var iCounter = 0;
            //oObjects = $.parseJSON(getResult.responseText);
            //alert (var_dump(oObjects));
            for (measurement in wt.measurements)
            {
                
                aLabels[iCounter] = measurement;
                aValues[iCounter]  = [];
                for (i in wt.measurements[measurement])
                {
                    //console.log(wt.measurements[measurement][i]);
                    aValues[iCounter].push([wt.measurements[measurement][i]['unix_date']*1000, parseInt(wt.measurements[measurement][i]['value'])]);
                }
                iCounter++;
            }
            

            /*aLabels[iCounter] = "measurement";
            aValues[iCounter]  = [];
            for (i in wt.measurements)
            {
                aValues[iCounter].push([wt.measurements[i]['unix_date']*1000, parseInt(wt.measurements[i]['value'])]);
            }
            iCounter++;
            */

            //alert (var_dump(aValues));
            //alert(aValues[0]);
            //console.log(aLabels);
            //console.log(aValues);

            /* we need to prepare array for ploting with labels */
            var aData = [];
            for (i=0; i<aValues.length; i++)
            {
                aData.push({data: aValues[i], label: aLabels[i]});
            }
            //alert (aData);
            /*
                     min: new Date(2013, 5, 1).getTime(),
                     max: new Date(2014, 3, 1).getTime(),
						*/

            $.plot($("#graph-placeholder"), aData, {
                    xaxis: { 
                     mode: "time", 
                     minTickSize: [10, "day"], 
                     timeformat: "%m.%y"}
                    }
                    );
        }
    });