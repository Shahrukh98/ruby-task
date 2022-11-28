# require 'googleauth'
# require 'google/apis/drive_v2'

# Drive = Google::Apis::DriveV2
# drive = Drive::DriveService.new
# # Drive::AUTH_DRIVE is equal to https://www.googleapis.com/auth/drive
# drive.authorization = Google::Auth.get_application_default([Drive::AUTH_DRIVE])

# a = drive.list_drives()

# puts a

# # folder_id = '1v8kAzirygnGsKm4X0eX_OhNgFPw865aQ'

require 'pdf-reader'

files = Dir['./files/*']

files.each { |file| 

    reader = PDF::Reader.new(file)

    reader.pages.each do |page|
        text = page.text
        puts text
        # if text.include? 'Judgment for Costs of Appointed Attorney'
        #     puts file
        #     puts "yes"
        # end
    end

}




