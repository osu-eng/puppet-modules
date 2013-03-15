# Check if the Unitrends directory exists.
if FileTest.directory?("/usr/bp")
    Facter.add("unitrends_directory_exists") do
        setcode { true }
    end
end
