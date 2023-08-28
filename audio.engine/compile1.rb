

def success(message,error)
  if $?.success?
    puts message
  else
    puts error
    exit 1
  end
end

file_name = "main"


system("gcc -c #{file_name}.c")
success("succeed compile","failed compile")

system("gcc #{file_name}.o -o t")
success("succeed linked","failed linked")
