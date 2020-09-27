control 'local' do
  bucket = attribute("bucket_name")
  reader_sa = attribute("reader_service_account_email")

  describe command("gsutil --impersonate-service-account #{reader_sa} cat gs://#{bucket}/file") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should match /^WARNING.*?impersonation.*?\n$/ }
    its(:stdout) { should eq 'hello world!' }
  end
end