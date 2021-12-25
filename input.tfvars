project_id = "helical-sanctum-336021"
network_name = "dabourvpc"
subnets = [
    {
      subnet_name   = "subnet-01"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "us-central1"
    } ]

dataset_id =  ["bigquerydataset1","bigquerydataset2","bigquerydataset3"]  //,"bigquerydataset2","bigquerydataset3"
dataset_name = ["bigquerydataset1","bigquerydataset2","bigquerydataset3"]  //,"bigquerydataset2","bigquerydataset3"
bucket_name = ["1","2","3"]
gcp_service_list = [
#  "bigquery-json.googleapis.com",     # BigQuery API
"cloudresourcemanager.googleapis.com",
  "bigquerystorage.googleapis.com",   # BigQuery Storage API
  "cloudapis.googleapis.com",         # Google Cloud APIs
  "clouddebugger.googleapis.com",     # Stackdriver Debugger API
  "cloudtrace.googleapis.com",        # Stackdriver Trace API
  "compute.googleapis.com",           # Compute Engine API
  "iam.googleapis.com",               # Identity and Access Management (IAM) API
  "iamcredentials.googleapis.com",    # IAM Service Account Credentials API
  "logging.googleapis.com",           # Stackdriver Logging API
  "monitoring.googleapis.com",        # Stackdriver Monitoring API
  "oslogin.googleapis.com",           # Cloud OS Login API
  "servicemanagement.googleapis.com", # Service Management API
  "serviceusage.googleapis.com",      # Service Usage API
  "sourcerepo.googleapis.com",        # Cloud Source Repositories API
  "sql-component.googleapis.com",     # Cloud SQL
  "storage-api.googleapis.com",       # Google Cloud Storage JSON API
  "storage-component.googleapis.com", # Cloud Storage
  "container.googleapis.com"
]

//GKE Input _______________________
region = "us-central1"
zones                      = ["us-central1-a", "us-central1-b"]

//GKE End _______________