## watashino_terrraform

### required
- AWS access key
- AWS secret access key

### terraform plan
```
terraform plan -var 'access_key=AK123456789123456789' -var 'secret_key=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
```

### terraform apply
```
terraform apply -var 'access_key=AK123456789123456789' -var 'secret_key=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
```

### terraform plan（for destroy）
```
terraform plan -destroy -var 'access_key=AK123456789123456789' -var 'secret_key=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' -out=./terraform.tfplan
```

### terraform apply（for destroy）
```
  terraform apply  ./terraform.tfplan
```
