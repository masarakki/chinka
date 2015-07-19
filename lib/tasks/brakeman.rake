desc 'brakeman'
task :brakeman do
  require 'brakeman'
  result = Brakeman.run app_path: '.', print_report: true
  exit Brakeman::Warnings_Found_Exit_Code unless result.filtered_warnings.empty?
end
