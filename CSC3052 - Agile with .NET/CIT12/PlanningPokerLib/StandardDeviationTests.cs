using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NUnit.Framework;

namespace PlanningPokerLib
{
    [TestFixture]
    public class StandardDeviationTests
    {
        [Test]
        public void PositiveIntergers()
        {
            PlanningPoker pp = new PlanningPoker();
            Int32[] values = new Int32[] { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
            Int32 anwser = pp.GetStandardDeviation((Int32[])values);
            Assert.AreEqual(4, anwser);

        }

        [Test]
        public void OneIntergers()
        {
            PlanningPoker pp = new PlanningPoker();
            Int32[] values = new Int32[] { 7 };
            Int32 anwser = pp.GetStandardDeviation((Int32[])values);
            

        }


        [Test]
        public void NegativeIntergers()
        {
            PlanningPoker pp = new PlanningPoker();
            Int32[] values = new Int32[] { -1, -2, -3, -4, -5, -6, -7, -8, -9, -10 };
            Int32 anwser = pp.GetStandardDeviation((Int32[])values);
            Assert.AreEqual(0, anwser);
        }

        [Test]
        public void MixedIntegers()
        {
            PlanningPoker pp = new PlanningPoker();
            Int32[] values = new Int32[] { -1, 2 - 3, 4, 5, 6, 7, 8, -9, 10 };
            Int32 answser = pp.GetStandardDeviation((Int32[])values);
            Assert.AreEqual(0, answser);
        }
    }
}
