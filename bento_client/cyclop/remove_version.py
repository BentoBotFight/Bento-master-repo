with open("requirements.txt", "r") as file:
    packages = file.readlines()

with open("requirements_no_versions.txt", "w") as file:
    for package in packages:
        package_name = package.split('==')[0].split('>=')[0].split('<=')[0].strip()
        file.write(package_name + "\n")

print("Versions removed. New file created: requirements_no_versions.txt")
