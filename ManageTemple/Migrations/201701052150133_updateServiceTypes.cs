namespace ManageTemple.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class updateServiceTypes : DbMigration
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
                        ServiceType_id = c.Int(),
                    })
                .PrimaryKey(t => t.id)
                .ForeignKey("dbo.ServiceTypes", t => t.ServiceType_id)
                .Index(t => t.ServiceType_id);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.ClientTypes", "ServiceType_id", "dbo.ServiceTypes");
            DropIndex("dbo.ClientTypes", new[] { "ServiceType_id" });
            DropTable("dbo.ClientTypes");
        }
    }
}
