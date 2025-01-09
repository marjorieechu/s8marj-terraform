# resource "aws_subnet" "public"
# count = length(va.availability_zone) # this is another way to provision subnets, using the count and length function
# the code will create a number of subnets equivalent to the number of availabilty zones

# cidr_block = cidrsubnet(var.cidr_block, 8, count.index) # 8 stands for the newbits. which when added to 16 gives the subnet mast number. the higer the mast the lower the ip address range. the count index number denots the number of subnets