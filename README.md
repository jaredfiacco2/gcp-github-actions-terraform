<!-- PROJECT SHIELDS -->
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<p align="center">

  <h3 align="center">Use GitHub Actions & Terraform to Automatically Spin up Resources in GCP.</h3>

  <p align="center">
    This project shows you how to connect your GCP project to GitHub Actions & run Terraform to spin up your infra from code instead of using the console or gcloud CLI. 
    <br />
    <br />
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#warning">Warning</a></li>
      </ul>
    </li>
    <li><a href="#instructions">Instructions</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

- This project shows you how to connect your GCP project to GitHub Actions & run Terraform to spin up your infra from code instead of using the console or gcloud CLI.  
- In this instance, we're using spinning up a bucket, adding an object to it, and creating a cloud function that references the object.

<img src="images\ProcessMap.png" alt="Process Map"/>


### WARNING
- Make sure you keep your repo private, don't ecpose your service account private key, don't allow anyone who merges to your repo to run actions. 
- You're ultimately responsible for your own security. If you don't know something, google it before you do it!

### Instructions

1. Create a new service acount in GCP & add the desied roles to the new service account
<img src="images\1. Create Service Account.png">
<img src="images\2. Add Roles To Service Account.png">

2. Open the service account you just made and create a new key. Open the JSON, copy the private key. 
<img src="images\3. Open Service Account.png">
<img src="images\4. Create Key.png">
<img src="images\5. Create JSON Key.png">

3. Open GitHub, go to your Repo's settings, and add a secret called "GOOGLE_CREDENTIALS". Your repo will use this to connect to GCP and run the terraform scripts. You need storage access, terraform needs to save it's states in a bucket. This prevents it from running into issues by attempting to create objests that already exist.
<img src="images\6. Add Private Key As GitHub Secret.png">

4. Edit your terraform.tfvars file variables to match your project_id, your tf state bucket's name, and the name you want for your infra bucket. Create a Google Cloud Storage Bucket to hold your terraform state. Make sure it's named with the same name as your tfvars "tf_state_bucket" variable. 
<img src="images\7. Create A Bucket To Hold The Terraform State.png">

5. Edit a tf file and push the changes to your branch. Merging to your branch should kick off github action to run your workflow.yaml file. This will run the terraform in gcp using the service acount credentials. The terraform will create a google storage buket, add your zipped python code as a bucket object, and create a cloud function using the object. Make sure the action runs and that check that the infra bucket, object, and google function were created.
<img src="images\8. Edit tf File - See GitHub Action Run.png">
<img src="images\9. Check Google Storage - See Infra Bucket & Storage Object The Action Created.png">
<img src="images\10. Check That Cloud Function Was Created.png">

<!-- CONTACT -->
## Contact

[Jared Fiacco](https://www.linkedin.com/in/jaredfiacco/) - jaredfiacco2@gmail.com

A GCP Project of Mine: [Pull and Store and Server Clash of Clans API Data](https://github.com/jaredfiacco2/ClashOfClans_API)

Another GCP Project of Mine: [Publish Computer Statistics to Pub/Sub, Use Cloud Functions to Store in BigQuery](https://github.com/jaredfiacco2/ComputerMonitoring_IOT)


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/jaredfiacco/