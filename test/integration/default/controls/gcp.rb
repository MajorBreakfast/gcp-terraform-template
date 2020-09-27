# Help: Inspec GCP docs: https://github.com/inspec/inspec-gcp

control 'gcp' do
  project = attribute("project")
  bucket = attribute("bucket_name")
  reader_sa = attribute("reader_service_account_email")

  describe google_storage_bucket(name: bucket, project: project) do
    it { should exist }
  end

  describe google_service_account(name: reader_sa, project: project) do
    it { should exist }
  end

  describe google_storage_bucket_iam_binding(bucket: bucket, role: "roles/storage.objectViewer") do
    it { should exist }
    its('members') { should include "serviceAccount:#{reader_sa}" }
  end
end