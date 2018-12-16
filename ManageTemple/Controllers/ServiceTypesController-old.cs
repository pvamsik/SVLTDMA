using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using ManageTemple.Models;

namespace ManageTemple.Controllers
{
    public class ServiceTypesController : Controller
    {
        private ApplicationDbContext db = new ApplicationDbContext();

        // GET: ServiceTypes
        public ActionResult Index()
        {
            if (TempData["ErrorDetails"] != null)
            {
                ModelState.AddModelError("", TempData["ErrorDetails"].ToString());
            }
            return View(db.ServiceTypes.ToList());
        }

        // GET: ServiceTypes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ServiceType serviceType = db.ServiceTypes.Find(id);
            if (serviceType == null)
            {
                return HttpNotFound();
            }
            return View(serviceType);
        }

        // GET: ServiceTypes/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: ServiceTypes/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "id,Name,Description,EffectiveDate,ExpirationDate,isDefault,isActive")] ServiceType serviceType)
        {
            if (ModelState.IsValid)
            {
                db.ServiceTypes.Add(serviceType);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(serviceType);
        }

        // GET: ServiceTypes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ServiceType serviceType = db.ServiceTypes.Find(id);
            if (serviceType == null)
            {
                return HttpNotFound();
            }
            return View(serviceType);
        }

        // POST: ServiceTypes/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id,Name,Description,EffectiveDate,ExpirationDate,isDefault,isActive")] ServiceType serviceType)
        {
            if (ModelState.IsValid)
            {
                db.Entry(serviceType).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(serviceType);
        }

        // GET: ServiceTypes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ServiceType serviceType = db.ServiceTypes.Find(id);
            if (serviceType == null)
            {
                return HttpNotFound();
            }
            return View(serviceType);
        }

        // POST: ServiceTypes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            ServiceType serviceType = db.ServiceTypes.Find(id);

            if(serviceType.isDefault)
            {
                ModelState.AddModelError("DeletionError", "Default Service Type cannot be deactivated");
                return View(serviceType);
            }

            if(serviceType.isActive)
            {
                serviceType.isActive = false;
            } 
            else
            {
                serviceType.isActive = true;
            }
            db.Entry(serviceType).State = EntityState.Modified;
            db.SaveChanges();

            //db.ServiceTypes.Remove(serviceType);
            //db.SaveChanges();
            return RedirectToAction("Index");
        }

        // POST: ServiceTypes/Update/5/Activate
        [HttpPost, ActionName("Update")]
        [ValidateAntiForgeryToken]
        public ActionResult Update(int? id, string task)
        {
            if (id == null | task == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            if ( !(new[] { "Activate", "DeActivate", "MakeDefault" }).Contains(task) )
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            ServiceType serviceType = db.ServiceTypes.Find(id);
            if (serviceType == null)
            {
                return HttpNotFound();
            }

            if(task == "MakeDefault")
            {
                if (serviceType.isDefault)
                {
                    return RedirectToAction("Index");
                }
                if (serviceType.isActive == false)
                {
                    TempData["ErrorDetails"] = "Only active Service Type can be set as Default";
                    //ModelState.AddModelError("MakeDefaultError", "Only active Service Type can be set as Default");
                    return RedirectToAction("Index");
                }

                ServiceType defaultServiceType = db.ServiceTypes.SingleOrDefault(x => x.isDefault == true);
                if (defaultServiceType != null)
                {
                    defaultServiceType.isDefault = false;
                    db.Entry(defaultServiceType).State = EntityState.Modified;
                }
                serviceType.isDefault = true;
                db.Entry(serviceType).State = EntityState.Modified;
                db.SaveChanges();
            }

            if (task == "Activate")
            {
                if (serviceType.isActive)
                {
                    TempData["ErrorDetails"] = "Service Type is already Active";
                    return RedirectToAction("Index");
                }

                serviceType.isActive = true;
                db.Entry(serviceType).State = EntityState.Modified;
                db.SaveChanges();
            }
            if(task == "DeActivate")
            {
                if (serviceType.isDefault)
                {
                    TempData["ErrorDetails"] = "Default Service Type can not be Deactivated";
                    //ModelState.AddModelError("DeactivateError", "Default Service Type can not be Deactivated");
                    return RedirectToAction("Index");
                }

                serviceType.isActive = false;
                db.Entry(serviceType).State = EntityState.Modified;
                db.SaveChanges();
            }

            return RedirectToAction("Index");
        }


        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
