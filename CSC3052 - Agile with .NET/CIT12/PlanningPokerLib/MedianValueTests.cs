using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NUnit.Framework;

namespace PlanningPokerLib
{
    [TestFixture]
    public class MedianValueTests
    {
        [Test]
        public void PositiveIntergers()
        {
            PlanningPoker pp = new PlanningPoker();
            Int32[] values = new Int32[] {1,2,3,4,5,6,7,8,9,10};
            Int32 anwser = pp.GetMedian((Int32[])values);
            Assert.AreEqual(6, anwser);
            
        }

        [Test]
        public void OneIntergers()
        {
            PlanningPoker pp = new PlanningPoker();
            Int32[] values = new Int32[] {7};
            Int32 anwser = pp.GetMedian((Int32[])values);
            Assert.AreEqual(7, anwser);

        }


        [Test]
        public void NegativeIntergers()
        {
            PlanningPoker pp = new PlanningPoker();
            Int32[] values = new Int32[] {-1,-2,-3,-4,-5,-6,-7,-8,-9,-10};
            Int32 anwser = pp.GetMedian((Int32[])values);
            Assert.AreEqual(-6, anwser);
        }

        [Test]
        public void MixedIntegers()
        {
            PlanningPoker pp = new PlanningPoker();
            Int32[] values = new Int32[] {-1, 2 - 3, 4, 5, 6, 7, 8, -9, 10};
            Int32 answser = pp.GetMedian((Int32[])values);
            Assert.AreEqual(6, answser);
        }

    }
}
