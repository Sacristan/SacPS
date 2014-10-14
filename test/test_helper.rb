require 'minitest/autorun'
require 'sacps'

def load_schema
  config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
  ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")

  db_adapter = ENV['DB']

  # no db passed, try one of these fine config-free DBs before bombing.
  db_adapter ||=
    begin
      require 'rubygems'
      require 'sqlite'
      'sqlite'
    rescue MissingSourceFile
      begin
        require 'sqlite3'
        'sqlite3'
      rescue MissingSourceFile
      end
    end

  if db_adapter.nil?
    raise "No DB Adapter selected. Pass the DB= option to pick one, or install Sqlite or Sqlite3."
  end

  ActiveRecord::Base.establish_connection(config[db_adapter])
  load(File.dirname(__FILE__) + "/schema.rb")
end

SacPS::Auth::Swedbank.identifier = 'ACC1'
SacPS::Auth::Swedbank.service_url = 'https://ib.swedbank.lv'
SacPS::Auth::Swedbank.return_url = 'http://www.myplace.com'

SacPS::Auth::Citadele.identifier = 'ACC1'
SacPS::Auth::Citadele.service_url = 'https://online.citadele.lv/amai/start.htm'
SacPS::Auth::Citadele.return_url = 'http://www.myplace.com'

#BEGIN CERTS
SacPS::Auth::Swedbank.private_key = <<EOF
-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQC+AROlXiRvi1T7Q9fAh0Lw73szAn26mqfKDqd6Bdplq3v+gVWC
3v0+bgtfNakRE/UVYOxEA0z0viqRpKzPuNy8OstTMe8fFKs19NW8lBYik6NzJ4Bk
+B6VmovOm0nJLQJytXKiJyuHP9DqPOVmP8S+azzX7Uqzov1nxo9fvH7y2QIDAQAB
AoGAFhbD9O6r57fYCloJxB01gBMnTHfWrBH8vbXUbJAvorA7+wuIKG3KHS7n7Yqs
fArI7FJXRVTo5m8RPdtaJ9ADAT9rjAi3A17TaEueyJl+B/hjHYhsd8MeFhTb2fh0
rY3F6diL8U/YDbiAIegnKO0zcc6ynJrsQZvzb6DlY/CLPe0CQQD3KXJzw1ZfJ1ts
c370b/ZC1YrRURw41Q0I8ljYJ8EJw/ngVxrnCIsd43bRnOVp9guJrjTQRkhDC3Gn
J2Y0+42LAkEAxMxmh7QY4nItBTS0fe1KCat4VDxhyxYEhZKlGDhxW75vNROrripB
1ZfBsq5xkY2MM9R7WKmL7SpStrUPIvEVqwJBAOXA4ISd61cupbytrDEbNscv7Afh
pyNpYOGVLmNYqQgj5c7WCcsD1RYmkRgPCe8y6czFZJDLFHdGVxLz+/16bTsCQC9J
Ob2TnYMTkhO1JUU4tdh69e+vjoPgp3d80+Rs83fq2wey0UaI6saqryUC21Dw5OYz
QOv92RxEVhmGibuIl/8CQCiYrzwlZJDlsKrWPZT0E8rzNmLZkhNHzYJP9S7x+FKk
m3gFeXEBgzGn9UOd6xIAp0p7A1XVBN8XzDMa09gSOks=
-----END RSA PRIVATE KEY-----
EOF

SacPS::Auth::Swedbank.public_key = <<EOF
-----BEGIN CERTIFICATE-----
MIIDRTCCAq6gAwIBAgIBADANBgkqhkiG9w0BAQQFADB7MQswCQYDVQQGEwJFRTEO
MAwGA1UECBMFSGFyanUxEDAOBgNVBAcTB1RhbGxpbm4xDDAKBgNVBAoTA0VZUDEL
MAkGA1UECxMCSVQxDDAKBgNVBAMTA2EuYTEhMB8GCSqGSIb3DQEJARYSYWxsYXIu
YWxsYXNAZXlwLmVlMB4XDTk5MTExNTA4MTAzM1oXDTk5MTIxNTA4MTAzM1owezEL
MAkGA1UEBhMCRUUxDjAMBgNVBAgTBUhhcmp1MRAwDgYDVQQHEwdUYWxsaW5uMQww
CgYDVQQKEwNFWVAxCzAJBgNVBAsTAklUMQwwCgYDVQQDEwNhLmExITAfBgkqhkiG
9w0BCQEWEmFsbGFyLmFsbGFzQGV5cC5lZTCBnzANBgkqhkiG9w0BAQEFAAOBjQAw
gYkCgYEAvgETpV4kb4tU+0PXwIdC8O97MwJ9upqnyg6negXaZat7/oFVgt79Pm4L
XzWpERP1FWDsRANM9L4qkaSsz7jcvDrLUzHvHxSrNfTVvJQWIpOjcyeAZPgelZqL
zptJyS0CcrVyoicrhz/Q6jzlZj/Evms81+1Ks6L9Z8aPX7x+8tkCAwEAAaOB2DCB
1TAdBgNVHQ4EFgQUFivCzZNmegEoOxYtg20YMMRB98gwgaUGA1UdIwSBnTCBmoAU
FivCzZNmegEoOxYtg20YMMRB98ihf6R9MHsxCzAJBgNVBAYTAkVFMQ4wDAYDVQQI
EwVIYXJqdTEQMA4GA1UEBxMHVGFsbGlubjEMMAoGA1UEChMDRVlQMQswCQYDVQQL
EwJJVDEMMAoGA1UEAxMDYS5hMSEwHwYJKoZIhvcNAQkBFhJhbGxhci5hbGxhc0Bl
eXAuZWWCAQAwDAYDVR0TBAUwAwEB/zANBgkqhkiG9w0BAQQFAAOBgQBfkayuot+e
fwW8QmPwpWF5AY3oMT/fTncjCljDBOg39IQv4PjnpTdDfwwl3lUIZHHTLM2i0L/c
eD4D1UFM1qdp2VZzhBd1eeMjxYjCP8qL2v2MfLkCYcP30Sl6ISSkFjFc5qbGXZOc
C82uR/wUZJDw9kj+R1O46/byG8yA+S9FVw==
-----END CERTIFICATE-----
EOF

SacPS::Auth::Citadele.private_key = <<EOF
-----BEGIN RSA PRIVATE KEY-----
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
-----END RSA PRIVATE KEY-----
EOF


SacPS::Auth::Citadele.public_key = <<EOF
-----BEGIN CERTIFICATE-----
MIIFhDCCA2wCCQCegSod3y7vmjANBgkqhkiG9w0BAQUFADCBgzELMAkGA1UEBhMC
TFYxDDAKBgNVBAgMA1VTQTENMAsGA1UEBwwEUmlnYTEYMBYGA1UECgwPQ3JlYXRp
dmUgTW9iaWxlMQswCQYDVQQLDAJJVDEPMA0GA1UEAwwGQXJ0dXJzMR8wHQYJKoZI
hvcNAQkBFhBhcnR1cnNAY3Jlby5tb2JpMB4XDTExMTEyMjE2MjIxMFoXDTE1MTEy
MTE2MjIxMFowgYMxCzAJBgNVBAYTAkxWMQwwCgYDVQQIDANVU0ExDTALBgNVBAcM
BFJpZ2ExGDAWBgNVBAoMD0NyZWF0aXZlIE1vYmlsZTELMAkGA1UECwwCSVQxDzAN
BgNVBAMMBkFydHVyczEfMB0GCSqGSIb3DQEJARYQYXJ0dXJzQGNyZW8ubW9iaTCC
AiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALykOU4K/D4IoKhnYUMfHrZM
syUo3NQyNJ4UWLMc89DPtRNu1hUyPtXme/zoNeElL5cTT2ltmdD6c/wrKp0JOJX0
4wrkUVAiyTMTORjC/zAmhpKezyHuirnNV4E7t0A8DBKdux4jeU2cECghVz21VxV7
el9SY7So9qpzrRztsLw+11D0Zun6kW3SLmfPnQs2k6BLgO2D6FFJbW3nXKqaGH6e
hY8EnQL2Pf5fRpQY2jx01i2+6oumRQqbDVphN7AqtgZlPhks+VnNR1PE8EGsRcdU
PgH/ZmBzdRGRe1bonngEclkpQUd6poa90xXQ4BtCXURhAYNUF6x5n8MSm6rKi/1e
T2SORfoV1nTeQZLfVHYPvjIi8KL0KzDsJn6gaP3ApZiF+BKwZZmO/8X8ICPJKdwS
afbRziyunZjLvj69IFibN3twib51OYmbdr1yo7qilTRsX7fi0kIaFB8i6VHhJVyu
6RUGYVvsCxSwMwrk0klSFD7S3afyC3KpsBykAFPwgeFXlJO+2ubF0CwL1kpG2OtY
cHq7EvNqeJy3SHJwzjktd5z+pPpgVkvn4sxmNqtadbU+lKDa7tF5yLsQXzoRZtCb
Y/m+cYUGTmNftcuoadj2e8BWHj1FEy1t8CQuM5shWfKKhhhCeqyuTuOxCvS08fdF
hOqcM621BddpFjXzczUpAgMBAAEwDQYJKoZIhvcNAQEFBQADggIBAFczQspZRvxP
mKmMEMSqjJy2HfhkeU6eAbJYIXQX19mveIscUzG/pWxOS5j6F9B1wS8EmIRgz5EW
KN0LdPXpfvy1R9yMGgiZW4JyyfTWgTNOQcVuN8QPltkMzEAqDnOd4gkF41N9qf42
/5wSzcU+rCF89UpdIig7KRopgyCcThRgBJ0UgqaSTm1qL+/+AZxzGjbPr4a+U2/A
xWzsoDA61zo/v6nQ3ZPCWiGoKsA1eO8Vh1YihTPo2HyrMgtXyWvG3p9DiNvyh6xP
vIGu5yJfxfa20X/xuHWB1xuyEF0NHq0Bb+7esvkZiNSALUlQSiUwdlN1cRv5UCtu
WeR1/4nboKV97euM1kP+f30Vrqs1RUlonDwiDlgBbUCFlU3OUomW4D9Lxhsi3Gab
pMI3HpjZ+8mazDdRxtD2TCmzGo+YjOwLUrXlVP0AHXAOaSWfQacleCAVyyH0ffE5
dByjB9tSIcxDijIkw1PHGazDnHKqOmG3VIVCQHS30xA+gjFrn1791grNQOI3pM/6
Gbhw8XRx6vks2T6yhAHDaCK+jOwLakW9pmheVG4DFxqSKXaLRQm+KOGQMhBzNKFO
mkqsF3eDhhx538HVDzbiqye7R21GhnCCZoEiPC0UcHDOKm3Yow3yQ64NON74lQCM
i02yWxFjh9NodTVRcdb4WBmSXprepw3G
-----END CERTIFICATE-----
EOF

