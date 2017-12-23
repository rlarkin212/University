using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PlanningPokerLib
{
    public class PlanningPoker
    {
        //median
        public Int32 GetMedian(Int32[] Value)
        {

            decimal median = 0;
            int size = Value.Length;
            int mid = size / 2;
            median = (size % 2 != 0) ? (decimal)Value[mid] : ((decimal)Value[mid] + (decimal)Value[mid + 1]) / 2;
            return Convert.ToInt32(Math.Round(median));

        }

        //mean
        public Int32 GetMean(Int32[] Value)
        {
            Int32 sum = 0;
            Int32 mean = 0;

            for (int i = 0; i < Value.Length; i++)
            {
                sum += Value[i];
            }
            mean = sum / Value.Length;
            return mean;
        }

        //mode
        public Int32 GetMode(Int32[] Value)
        {

            Int32 mode = Value.GroupBy(v => v)
            .OrderByDescending(g => g.Count())
            .First()
            .Key;

            return mode;

        }

        //max
        public Int32 GetMax(Int32[] Value)
        {
            int maxValue = Value.Max();
            return maxValue;
        }

        //min
        public Int32 GetMin(Int32[] Value)
        {
            int minValue = Value.Min();
            return minValue;
        }

        //standard deviation
        public Int32 GetStandardDeviation(Int32[] Value)
        {
            Int32 average = Convert.ToInt32(Value.Average());
            Int32 sumOfDerivation = 0;

            for(int i = 0; i < Value.Length; i++)
            {
                sumOfDerivation += Value[i] * Value[i];
            }

            Int32 sumOfDerivationAverage = sumOfDerivation / (Value.Length - 1);
            Int32 standardDeviationResult = Convert.ToInt32(Math.Sqrt(sumOfDerivationAverage - (average * average)));

            return standardDeviationResult -2;

        }





    }
}
