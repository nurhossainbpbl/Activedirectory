# Specify the distribution group name
$groupName = "testdg@bdlab.cloudns.ph"

# Get all members of the distribution group
$members = Get-DistributionGroupMember -Identity $groupName

# Loop through each member and set the "User must change password at next logon" property
foreach ($member in $members) {
    # Check if the member is a user mailbox (excluding other types like contacts or groups)
    if ($member.RecipientType -eq "UserMailbox") {
        # Get the user object associated with the mailbox
        $user = Get-User -Identity $member.PrimarySmtpAddress

        # Set the "User must change password at next logon" property
        $user | Set-ADUser -ChangePasswordAtLogon $true
    }
}
