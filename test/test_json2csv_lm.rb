require 'minitest/autorun'
# require_relative '../lib/json2csv_lm.rb'
require 'json2csv_lm'
# require 'csv'

class Json2csvLmTest < Minitest::Test
  def setup
    # Delete the result of the last test
    File.delete(File.expand_path("output.csv", File.dirname(__FILE__))) if File.exist?(File.expand_path("output.csv", File.dirname(__FILE__)))

    # running the convert method to be able to test the result (the output.csv file)
    input_filepath = File.expand_path("test_given.json", File.dirname(__FILE__))
    output_filepath = File.expand_path("output.csv", File.dirname(__FILE__))
    Json2csvLm.convert(input_filepath, output_filepath)

    # parsing the 2 files (output.csv & expected_out.csv) to compare their content
    @parsing_result = []
    output_filepath = File.expand_path("output.csv", File.dirname(__FILE__))
    CSV.foreach(output_filepath) { |row| @parsing_result << row }

    @expected_parsing_result = []
    expected_output_filepath = File.expand_path( "expected_output.csv" , File.dirname(__FILE__))
    CSV.foreach(expected_output_filepath) { |row| @expected_parsing_result << row }
  end

  def test_convert
    assert_equal( @expected_parsing_result, @parsing_result)
  end

  def test_json_parsing
    assert_equal([
                  {"id"=>0, "email"=>"test@test.com", "results"=>[10, 8, 2], "profiles"=>{"facebook"=>{"id"=>0, "nickname"=>"SuperTester"}, "twitter"=>{"id"=>0, "nickname"=>"SuperTester"}}},
                  {"id"=>1, "email"=>"azer@azer.com", "results"=>[9, 9, 9], "profiles"=>{"facebook"=>{"id"=>1, "nickname"=>"AzerPower"}, "twitter"=>{"id"=>1, "nickname"=>"AzerPower"}}}
                ],
      Json2csvLm.parse_json_file(File.expand_path("test_happy.json", File.dirname(__FILE__))))
  end

  # def test_json_parsing_wrong_format_exception
  #   assert_equal((stdout = "Error: parseError: file can't be parsed, check format"),
  #     Json2csvLm.parse_json_file("/home/bidjit/code/Bidjit/livementor/json2csv_lm/test/bad_format.json"))
  # end
end
