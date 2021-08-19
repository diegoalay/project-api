(0..5).each do |n|
  create_user()
end

[
  "jonh.doe@ibm.com",
  "jondoe@ibm.com",
  "jon-doe@ibm.com",
  "homer@simpsons.com",
  "homero@simpsons.mx",
  "diego.alay@hotmail.mx",
  "diegoalay@hotmail.com",
  "alay@hotmail.com"
].each do |email|
  create_user(email)
end