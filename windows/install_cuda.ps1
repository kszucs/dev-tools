$ie = New-Object -ComObject 'InternetExplorer.Application'
$ie.Navigate('https://developer.nvidia.com/cuda-downloads')
$ie.Document.getElementById('target_Windows').click()
$ie.Document.getElementById('target_x86_64').click()
$ie.Document.getElementById('target_10').click()
$ie.Document.getElementById('target_exenetwork').click()
$latest_cuda = $ie.Document.getElementById('targetDownloadButtonHref').href
iwr -Uri $latest_cuda -OutFile 'install_cuda.exe'
.\install_cuda.exe -s

