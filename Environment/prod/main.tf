module "resource_group" {
  source = "../../child/resource_group"


  sandyrg = {
    rg1 = {
      name     = "rgprodsandy"
      location = "Central India"
    }

  }
}
module "vent" {
  source = "../../child/vnet"
  depends_on = [module.resource_group]

  vnetsandy = {
    vnet1 = {
      name                = "vnetprodsandy"
      resource_group_name = "rgprodsandy"
        location = "Central India"
      address_space       = ["10.32.0.0/16"]
    }
  }

}

module "subnet" {
  source = "../../child/subnet"
  depends_on = [ module.resource_group,module.vent ]
  subnetsandy = {
    subnet1 = {
      subnet_name                 = "frontendsandy"
      resource_group_name  = "rgprodsandy"
      virtual_network_name = "vnetprodsandy"
      address_prefixes     = ["10.32.1.0/24"]
    }
    subnet2 = {
      subnet_name                 = "backendsandy"
      resource_group_name  = "rgprodsandy"
      virtual_network_name = "vnetprodsandy"
      address_prefixes     = ["10.32.2.0/24"]
    }
    # subnet3 = {
    #   name                 = "databasesandy"
    #   resource_group_name  = "rgprodsandy"
    #   virtual_network_name = "vnettprodsandy"
    #   address_prefixes     = ["10.32.3.0/24"]
    # }
  }
}

module "public_ip"{
    source = "../../child/public_ip"
    depends_on = [ module.resource_group]
    pip={
    pip1={
        pipname                = "pipfrontendsandy"
  resource_group_name = "rgprodsandy"
  location = "Central India"

    }
    pip2={
                pipname                = "pipbackendsandy"
  resource_group_name = "rgprodsandy"
  location = "Central India"

    }

}
}

module "vm"{
    source = "../../child/virtual_machine"
    depends_on = [ module.vent,module.subnet ]
    vms = {
    vm1={
          vm_name                = "vmprodsandy1"
  resource_group_name = "rgprodsandy"
  location = "Central India"
  nic_name="nicfrontendsandy"
  virtual_network_name = "vnetprodsandy"
     subnet_name                 = "frontendsandy"
     pipname                = "pipfrontendsandy"
     size="Standard_B1s"
    #  Standard_D4_v5
# Standard_D2_V3


  
    }
    vm2={
        vm_name                = "vmprodsandy2"
  resource_group_name = "rgprodsandy"
  location = "Central India"
    nic_name="nicbackendsandy"
  virtual_network_name = "vnetprodsandy"
     subnet_name                 = "backendsandy"
     pipname                = "pipbackendsandy"
  size="Standard_B1s"
    }
}
}

