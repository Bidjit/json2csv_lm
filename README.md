# json2csv_lm

`json2csv_lm` is a gem converting JSON files composed of arrays
of objects (all following the same schema) to a CSV file where one line equals one object.

---

## Installation

Since the gem is not published to RubyGems.org, you have to install it manually, simply copy the `json2csv_lm-0.0.1.gem` file on your computer, then run the following (from the `json2csv_lm-0.0.1.gem` file's directory ):

```bash
$ gem install ./json2csv_lm-0.0.1.gem  # adatp the filepath if you run this line from another directory
```

Now you can `require 'json2csv_lm'` in any file you need to :)

---

## Basic Usage

#### *** Beware of the restrictions: ***
  - all objects of the json file must be following the same schema
  - keys of the json file should NOT contain any `,`
  - array values should NOT contain any `|`

Very simple, only one method : #convert(input_filepath, output_filepath = nil)

**Json2csv.convert(json_filepath, output_filepath = nil)**
create or replace the file at `the output_filepath` location
if the `output_filepath` is not given, create or replace the output.csv file in the json_file's directory

---

## Examples

```ruby
Json2csvLm.convert("/home/bidjit/code/Bidjit/data.json")
```
=> It will create or overwrite a csv file (filepath: `/home/bidjit/code/Bidjit/output.csv`)



```ruby
Json2csvLm.convert("/home/bidjit/code/Bidjit/data.json", "/home/bidjit/code/Bidjit/db/data_01.csv")
```
=> It will create or overwrite a csv file (filepath: `/home/bidjit/code/Bidjit/db/data_01.csv`)

---

#### Happy converting !!!
