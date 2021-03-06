(function(speak) {
  speak.pageCode([],function() {
    return {
      
      
      initialized: function() {
        //this.AreaChartSingleSeries.toggleProgressIndicator(true);                
          
        var data = {
          "localization": {
            "fields": [
              {
                "field": "channel",
                "translations": {
                  "10": "Search Engine Organic",
                  "15": "Search Engine Organic Branded",
                  "20": "Direct",
                  "30": "Referred-Other",
                  "31": "Referred-Blog",
                  "32": "Referred-News",
                  "33": "Referred-Conversations",
                  "34": "Referred-Community",
                  "35": "Referred-Wiki",
                  "36": "Referred-Analyst",
                  "40": "RSS",
                  "50": "Email",
                  "90": "Paid"
                }
              }
            ]
          },

          "dataset": [
            {
              "data": [
                {
                  "date": "2010",
                  "value": "1",
                  "visits": "1100000",
                  "valuePerVisit": "0.09",
                  "channel": "10",
                  "segmentTooltip": "Lorem ipsum{br}Test"
                },
                {
                  "date": "2010",
                  "value": "2",
                  "visits": "12",
                  "valuePerVisit": "0.16",
                  "channel": "50",
                  "segmentTooltip": "Lorem ipsum 2{br}Test"
                },
                {
                  "date": "2010",
                  "value": "3",
                  "visits": "1300000",
                  "valuePerVisit": "0.23",
                  "channel": "20"
                },
                {
                  "date": "2011",
                  "value": "4",
                  "visits": "1400000",
                  "valuePerVisit": "0.28",
                  "channel": "10",
                  "segmentTooltip": "Lorem ipsum 3{br}Test"
                },
                {
                  "date": "2011",
                  "value": "5",
                  "visits": "1500000",
                  "valuePerVisit": "0.33",
                  "channel": "50"
                },
                {
                  "date": "2011",
                  "value": "6",
                  "visits": "1600000",
                  "valuePerVisit": "0.37",
                  "channel": "20"
                },
                {
                  "date": "2012",
                  "value": "1",
                  "visits": "1100000",
                  "valuePerVisit": "0.09",
                  "channel": "10"
                },
                {
                  "date": "2012",
                  "value": "2",
                  "visits": "1200000",
                  "valuePerVisit": "0.16",
                  "channel": "50"
                },
                {
                  "date": "2012",
                  "value": "3",
                  "visits": "1300000",
                  "valuePerVisit": "0.23",
                  "channel": "20"
                },
                {
                  "date": "2013",
                  "value": "4",
                  "visits": "1400000",
                  "valuePerVisit": "0.28",
                  "channel": "10"
                },
                {
                  "date": "2013",
                  "value": "5",
                  "visits": "1500000",
                  "valuePerVisit": "0.33",
                  "channel": "50"
                },
                {
                  "date": "2013",
                  "value": "6",
                  "visits": "1600000",
                  "valuePerVisit": "0.37",
                  "channel": "20"
                }
              ]
            }
          ]
        };


        var splittedData = 	{
          "localization": {
            "fields": [
              {
                "field":"channel",
                "translations": {
                  "10":"Search Engine Organic",
                  "15":"Search Engine Organic Branded",
                  "20":"Direct",
                  "30":"Referred-Other",
                  "31":"Referred-Blog",
                  "32":"Referred-News",
                  "33":"Referred-Conversations",
                  "34":"Referred-Community",
                  "35":"Referred-Wiki",
                  "36":"Referred-Analyst",
                  "40":"RSS",
                  "50":"Email",
                  "90":"Paid"
                }
              }
            ]
          },
          "dataset": [
            {
              "data": [
                {
                  "date":"2010",
                  "value":"1",
                  "visits":"11",
                  "valuePerVisit":"0.09",
                  "channel":"10"
                },
                {
                  "date":"2010",
                  "value":"2",
                  "visits":"12",
                  "valuePerVisit":"0.16",
                  "channel":"50"
                },
                {
                  "date":"2010",
                  "value":"3",
                  "visits":"13",
                  "valuePerVisit":"0.23",
                  "channel":"20"
                },
                {
                  "date":"2011",
                  "value":"4",
                  "visits":"14",
                  "valuePerVisit":"0.28",
                  "channel":"10"
                },
                {
                  "date":"2011",
                  "value":"5",
                  "visits":"15",
                  "valuePerVisit":"0.33",
                  "channel":"50"
                },
                {
                  "date":"2011",
                  "value":"6",
                  "visits":"16",
                  "valuePerVisit":"0.37",
                  "channel":"20"
                },
                {
                  "date":"2012",
                  "value":"1",
                  "visits":"11",
                  "valuePerVisit":"0.09",
                  "channel":"10"
                },
                {
                  "date":"2012",
                  "value":"2",
                  "visits":"12",
                  "valuePerVisit":"0.16",
                  "channel":"50"
                },
                {
                  "date":"2012",
                  "value":"3",
                  "visits":"13",
                  "valuePerVisit":"0.23",
                  "channel":"20"
                },
                {
                  "date":"2013",
                  "value":"4",
                  "visits":"14",
                  "valuePerVisit":"0.28",
                  "channel":"10"
                },
                {
                  "date":"2013",
                  "value":"5",
                  "visits":"15",
                  "valuePerVisit":"0.33",
                  "channel":"50"
                },
                {
                  "date":"2013",
                  "value":"6",
                  "visits":"16",
                  "valuePerVisit":"0.37",
                  "channel":"20"
                }
              ]
            },
            {
              "data": [
                {
                  "date":"2010",
                  "value":"10",
                  "visits":"11",
                  "valuePerVisit":"0.09",
                  "channel":"10"
                },
                {
                  "date":"2010",
                  "value":"2",
                  "visits":"12",
                  "valuePerVisit":"0.16",
                  "channel":"50"
                },
                {
                  "date":"2010",
                  "value":"33",
                  "visits":"13",
                  "valuePerVisit":"0.23",
                  "channel":"20"
                },
                {
                  "date":"2011",
                  "value":"4",
                  "visits":"14",
                  "valuePerVisit":"0.28",
                  "channel":"10"
                },
                {
                  "date":"2011",
                  "value":"5",
                  "visits":"15",
                  "valuePerVisit":"0.33",
                  "channel":"50"
                },
                {
                  "date":"2011",
                  "value":"726",
                  "visits":"16",
                  "valuePerVisit":"0.37",
                  "channel":"20"
                },
                {
                  "date":"2012",
                  "value":"1",
                  "visits":"11",
                  "valuePerVisit":"0.09",
                  "channel":"10"
                },
                {
                  "date":"2012",
                  "value":"2",
                  "visits":"12",
                  "valuePerVisit":"0.16",
                  "channel":"50"
                },
                {
                  "date":"2012",
                  "value":"3",
                  "visits":"13",
                  "valuePerVisit":"0.23",
                  "channel":"20"
                },
                {
                  "date":"2013",
                  "value":"4",
                  "visits":"14",
                  "valuePerVisit":"0.28",
                  "channel":"10"
                },
                {
                  "date":"2013",
                  "value":"5",
                  "visits":"15",
                  "valuePerVisit":"0.33",
                  "channel":"50"
                },
                {
                  "date":"2013",
                  "value":"6",
                  "visits":"16",
                  "valuePerVisit":"0.37",
                  "channel":"20"
                }
              ]
            },
            {
              "data": [
                {
                  "date":"2010",
                  "value":"10",
                  "visits":"11",
                  "valuePerVisit":"0.09",
                  "channel":"10"
                },
                {
                  "date":"2010",
                  "value":"20",
                  "visits":"12",
                  "valuePerVisit":"0.16",
                  "channel":"50"
                },
                {
                  "date":"2010",
                  "value":"30",
                  "visits":"13",
                  "valuePerVisit":"0.23",
                  "channel":"20"
                },
                {
                  "date":"2011",
                  "value":"4",
                  "visits":"14",
                  "valuePerVisit":"0.28",
                  "channel":"10"
                },
                {
                  "date":"2011",
                  "value":"5",
                  "visits":"15",
                  "valuePerVisit":"0.33",
                  "channel":"50"
                },
                {
                  "date":"2011",
                  "value":"6",
                  "visits":"16",
                  "valuePerVisit":"0.37",
                  "channel":"20"
                },
                {
                  "date":"2012",
                  "value":"51",
                  "visits":"11",
                  "valuePerVisit":"0.09",
                  "channel":"10"
                },
                {
                  "date":"2012",
                  "value":"52",
                  "visits":"12",
                  "valuePerVisit":"0.16",
                  "channel":"50"
                },
                {
                  "date":"2012",
                  "value":"53",
                  "visits":"13",
                  "valuePerVisit":"0.23",
                  "channel":"20"
                },
                {
                  "date":"2013",
                  "value":"4",
                  "visits":"14",
                  "valuePerVisit":"0.28",
                  "channel":"10"
                },
                {
                  "date":"2013",
                  "value":"5",
                  "visits":"15",
                  "valuePerVisit":"0.33",
                  "channel":"50"
                },
                {
                  "date":"2013",
                  "value":"6",
                  "visits":"16",
                  "valuePerVisit":"0.37",
                  "channel":"20"
                }
              ]
            },
            {
              "data": [
                {
                  "date":"2010",
                  "value":"1",
                  "visits":"11",
                  "valuePerVisit":"0.09",
                  "channel":"10"
                },
                {
                  "date":"2010",
                  "value":"2",
                  "visits":"12",
                  "valuePerVisit":"0.16",
                  "channel":"50"
                },
                {
                  "date":"2010",
                  "value":"3",
                  "visits":"13",
                  "valuePerVisit":"0.23",
                  "channel":"20"
                },
                {
                  "date":"2011",
                  "value":"4",
                  "visits":"14",
                  "valuePerVisit":"0.28",
                  "channel":"10"
                },
                {
                  "date":"2011",
                  "value":"5",
                  "visits":"15",
                  "valuePerVisit":"0.33",
                  "channel":"50"
                },
                {
                  "date":"2011",
                  "value":"6",
                  "visits":"16",
                  "valuePerVisit":"0.37",
                  "channel":"20"
                },
                {
                  "date":"2012",
                  "value":"1",
                  "visits":"11",
                  "valuePerVisit":"0.09",
                  "channel":"10"
                },
                {
                  "date":"2012",
                  "value":"2",
                  "visits":"12",
                  "valuePerVisit":"0.16",
                  "channel":"50"
                },
                {
                  "date":"2012",
                  "value":"3",
                  "visits":"13",
                  "valuePerVisit":"0.23",
                  "channel":"20"
                },
                {
                  "date":"2013",
                  "value":"4",
                  "visits":"14",
                  "valuePerVisit":"0.28",
                  "channel":"10"
                },
                {
                  "date":"2013",
                  "value":"5",
                  "visits":"15",
                  "valuePerVisit":"0.33",
                  "channel":"50"
                },
                {
                  "date":"2013",
                  "value":"6",
                  "visits":"16",
                  "valuePerVisit":"0.37",
                  "channel":"20"
                }
              ]
            },
            {
              "data": [
                {
                  "date":"2010",
                  "value":"1",
                  "visits":"11",
                  "valuePerVisit":"0.09",
                  "channel":"10"
                },
                {
                  "date":"2010",
                  "value":"2",
                  "visits":"12",
                  "valuePerVisit":"0.16",
                  "channel":"50"
                },
                {
                  "date":"2010",
                  "value":"3",
                  "visits":"13",
                  "valuePerVisit":"0.23",
                  "channel":"20"
                },
                {
                  "date":"2011",
                  "value":"4",
                  "visits":"14",
                  "valuePerVisit":"0.28",
                  "channel":"10"
                },
                {
                  "date":"2011",
                  "value":"5",
                  "visits":"15",
                  "valuePerVisit":"0.33",
                  "channel":"50"
                },
                {
                  "date":"2011",
                  "value":"6",
                  "visits":"16",
                  "valuePerVisit":"0.37",
                  "channel":"20"
                },
                {
                  "date":"2012",
                  "value":"1",
                  "visits":"11",
                  "valuePerVisit":"0.09",
                  "channel":"10"
                },
                {
                  "date":"2012",
                  "value":"2",
                  "visits":"12",
                  "valuePerVisit":"0.16",
                  "channel":"50"
                },
                {
                  "date":"2012",
                  "value":"3",
                  "visits":"13",
                  "valuePerVisit":"0.23",
                  "channel":"20"
                },
                {
                  "date":"2013",
                  "value":"4",
                  "visits":"14",
                  "valuePerVisit":"0.28",
                  "channel":"10"
                },
                {
                  "date":"2013",
                  "value":"5",
                  "visits":"15",
                  "valuePerVisit":"0.33",
                  "channel":"50"
                },
                {
                  "date":"2013",
                  "value":"6",
                  "visits":"16",
                  "valuePerVisit":"0.37",
                  "channel":"20"
                }
              ]
            }
          ]
        };

        this.ColumnChartSingleSeries.DynamicData = data;
        this.ColumnChartSeries.DynamicData = data;
        this.ColumnChartNonFilteredSeriesStacked.DynamicData = data;
        this.ColumnChartFilteredSeriesStacked.DynamicData = data;
        this.ColumnChartSplitting.DynamicData = splittedData;
      },
    };
  }, "SubAppRenderer");
})(Sitecore.Speak);