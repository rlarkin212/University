using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NUnit.Framework;

namespace PlanningPokerLib
{
    [TestFixture]
    public class ModeValueTests
    {
        [Test]
        public void PositiveIntergers()
        {
            PlanningPoker pp = new PlanningPoker();
            Int32[] values = new Int32[] { 1, 2, 2, 3, 2, 6, 6, 7, 9, 10 };
            Int32 anwser = pp.GetMode((Int32[])values);
            Assert.AreEqual(2, anwser);

        }

        [Test]
        public void OneIntergers()
        {
            PlanningPoker pp = new PlanningPoker();
            Int32[] values = new Int32[] { 7 };
            Int32 anwser = pp.GetMode((Int32[])values);
            Assert.AreEqual(7, anwser);

        }


        [Test]
        public void NegativeIntergers()
        {
            PlanningPoker pp = new PlanningPoker();
            Int32[] values = new Int32[] { -1, -2, -3, -4, -5, -6, -7, -8, -9, -10 };
            Int32 anwser = pp.GetMode((Int32[])values);
            Assert.AreEqual(-1, anwser);
        }

        [Test]
        public void MixedIntegers()
        {
            PlanningPoker pp = new PlanningPoker();
            Int32[] values = new Int32[] { -1, 2 - 3, 4, 5, 6,-9, 7, 8,-9,-9,10 };
            Int32 answser = pp.GetMode((Int32[])values);
            Assert.AreEqual(-9, answser);
        }
    }
}
