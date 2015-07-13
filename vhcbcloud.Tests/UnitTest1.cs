using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Collections.Generic;

namespace vhcbcloud.Tests
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void TestMethod1()
        {
          List<string> a =    vhcbcloud._Default.GetProjectName("a");
        }
    }
}
