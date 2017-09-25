Cuke Report Generator
=====================

This app takes cucumber JSON output and formats it into an HTML report based on Highcharts and Bootstrap 

Usage
------------------
<code>bundle exec cuke_report_generator</code>

SYNOPSIS
------------------

<code>
    cuke_report_generator [global options] command [command options] [arguments...]
</code>

GLOBAL OPTIONS
------------------
This is a list of 'about' the utility commands

<code>
    --help    - Show this message<br>
    --version - Display the program version
</code>

COMMANDS
------------------
This is a list of general commands

```
    generate      - Generate Report<br>
    help          - Shows a list of commands or help for one command<br>
    validate_json - Validate JSON is valid file before proceeding<br>
```

Generate
------------------
This command generates the output file.  It'll generate a main.html, errors.html, and a series of guidxxxx.html files.  The main.html file is the one to open to review the report.

```
   -d delete?  - Delete all html file extensions from output directory (default: false)<br>
   -e Name     - Environment Name (default: none)<br>
   -i filename - Input File - Specify the input JSON file (default: results.json)<br>
   -n Name     - Test Suite Name (default: none)<br>
   -o filename - Output File Directory - Specify relative folder directory to place the output html files (default: ./output)<br>
```
   
Validate_JSON
------------------
Use this command to validate the json file before attempting to create the output file.  This is primarily used for debugging purposes.

```
-i filename - Input File - Specify the input JSON file (default: results.json)
```

Example usages
------------------
```feature
    Given You have a report named 'EDH_Daily_Substance___edh_dev_daily___201709201327'
    And You want to clear out the default output directory
    Then You will want to run this command
```
<code>bundle exec cuke_report_generator generate -i EDH_Daily_Substance___edh_dev_daily___201709201327.json -d true</code>



```*.feature
    Given You have a report named 'EDH_Daily_Substance___edh_dev_daily___201709201327'
    And You want to clear out the default output directory
    And you want to set the output directory
    And you want to set the suite name to show in the report
    Then You will want to run this command
```
<code>bundle exec cuke_report_generator generate -i EDH_Daily_Substance___edh_dev_daily___201709201327.json -d true -o ./testoutput -n 'Test EDH'</code>