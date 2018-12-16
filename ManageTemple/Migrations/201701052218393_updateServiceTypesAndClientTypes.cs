namespace ManageTemple.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class updateServiceTypesAndClientTypes : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.ClientTypes",
                c => new
                    {
                        id = c.Int(nullable: false, identity: true),
                        Name = c.String(nullable: false, maxLength: 26),
                        isDefault = c.Boolean(nullable: false),
                        isActive = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.id);
            
            CreateTable(
                "dbo.ServiceTypeClientTypes",
                c => new
                    {
                        ServiceType_id = c.Int(nullable: false),
                        ClientType_id = c.Int(nullable: false),
                    })
                .PrimaryKey(t => new { t.ServiceType_id, t.ClientType_id })
                .ForeignKey("dbo.ServiceTypes", t => t.ServiceType_id, cascadeDelete: true)
                .ForeignKey("dbo.ClientTypes", t => t.ClientType_id, cascadeDelete: true)
                .Index(t => t.ServiceType_id)
                .Index(t => t.ClientType_id);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.ServiceTypeClientTypes", "ClientType_id", "dbo.ClientTypes");
            DropForeignKey("dbo.ServiceTypeClientTypes", "ServiceType_id", "dbo.ServiceTypes");
            DropIndex("dbo.ServiceTypeClientTypes", new[] { "ClientType_id" });
            DropIndex("dbo.ServiceTypeClientTypes", new[] { "ServiceType_id" });
            DropTable("dbo.ServiceTypeClientTypes");
            DropTable("dbo.ClientTypes");
        }
    }
}
