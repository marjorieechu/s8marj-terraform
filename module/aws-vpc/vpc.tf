# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.tags,
    { Name = "${var.name}" }
  )
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.tags,
    { Name = "${var.name}-igw" }
  )
}

# #Public Subnets
# resource "aws_subnet" "public" {
#   count = 3
#   vpc_id                  = aws_vpc.vpc.id
#   cidr_block              = cidrsubnet(var.vpc_cidr, 3, count.index)
#   map_public_ip_on_launch = true
#   availability_zone       = element(var.availability_zones, count.index)

#   tags = merge(
#     var.tags,
#     { Name = "${var.name}-public-subnet-${count.index + 1}" }
#   )
# }


#Public Subnets
resource "aws_subnet" "public" {
  for_each = tomap({
    public-1 = { cidr_block = cidrsubnet(var.vpc_cidr, 3, 0), az = var.availability_zones[0] }
    public-2 = { cidr_block = cidrsubnet(var.vpc_cidr, 3, 1), az = var.availability_zones[1] }
    public-3 = { cidr_block = cidrsubnet(var.vpc_cidr, 3, 2), az = var.availability_zones[2] }
  })

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    { Name = "${var.name}-${each.key}" }
  )
}


# # Private Subnets
# resource "aws_subnet" "private" {
#   count = 3
#   vpc_id            = aws_vpc.vpc.id
#   cidr_block        = cidrsubnet(var.vpc_cidr, 3, count.index + 3)
#   availability_zone = element(var.availability_zones, count.index)

#   tags = merge(
#     var.tags,
#     { Name = "${var.name}-private-subnet-${count.index + 1}" }
#   )
# }

# Private Subnets
resource "aws_subnet" "private" {
  for_each = tomap({
    private-1 = { cidr_block = cidrsubnet(var.vpc_cidr, 3, 3), az = var.availability_zones[0] }
    private-2 = { cidr_block = cidrsubnet(var.vpc_cidr, 3, 4), az = var.availability_zones[1] }
    private-3 = { cidr_block = cidrsubnet(var.vpc_cidr, 3, 5), az = var.availability_zones[2] }
  })

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az

  tags = merge(
    var.tags,
    { Name = "${var.name}-${each.key}" }
  )
}

# NAT Gateway Elastic IP
resource "aws_eip" "nat" {
  vpc = true

  tags = merge(
    var.tags,
    { Name = "${var.name}-nat-eip" }
  )
}

# NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public["public-1"].id

  tags = merge(
    var.tags,
    { Name = "${var.name}-nat-gateway" }
  )
}

# Route Tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(
    var.tags,
    { Name = "${var.name}-public-rt" }
  )
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = merge(
    var.tags,
    { Name = "${var.name}-private-rt" }
  )
}

# # Route Table Associations
# resource "aws_route_table_association" "public" {
#   count = 3

#   subnet_id      = aws_subnet.public[count.index].id
#   route_table_id = aws_route_table.public.id
# }

# resource "aws_route_table_association" "private" {
#   count = 3

#   subnet_id      = aws_subnet.private[count.index].id
#   route_table_id = aws_route_table.private.id
# }

# Public Route Table Associations
resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# Private Route Table Associations
resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}
