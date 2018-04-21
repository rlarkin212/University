using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace CIT12
{
    public class EmailAttachment
    {


        public static void UploadAttachment(int size, string name, Control control)
        {
            string upPath = "~files";

            if (!Directory.Exists(upPath))
            {
                Directory.CreateDirectory(upPath);
            }
            else
            {
                int fileSize = size;
                string fileName = name;
                string filePath = "~/files/" + fileName;

                if (fileSize > 1500000)
                {
                    
                }
                else
                {
                    //then save it to the Folder
                    //control.SaveAs(Server.MapPath(imgPath));
                    

                }
            }
        }


    }
}