import java.text.DecimalFormat;

 class VectorB {
    private int rows;
    private double[] values;

     public VectorB(int rows) {
        this.rows = rows;
        values = new double[rows];
    }

     public double lengthOfVector() {
        double length = 0.0;
        for (int i = 0; i < this.values.length; i++) {
            length += this.values[i] * this.values[i];
        }
        return Math.sqrt(length);
    }

     public VectorB scalarMultiplication(double scalar) {
        VectorB result = new VectorB(this.rows);
        for (int i = 0; i < this.rows; i++) {
            result.values[i] = this.values[i] * scalar;
        }
        return result;
    }

     public VectorB normal() {
        VectorB result = new VectorB(this.rows);
        for (int i = 0; i < this.rows; i++) {
            result.values[i] = this.values[i] / lengthOfVector();
        }
        return result;
    }

     public int findGreatestIndex() {
        int maxIndex = 0;
        for (int i = 1; i < values.length; i++) {
            maxIndex = Math.abs(values[i]) > Math.abs(values[maxIndex]) ? i : maxIndex;
        }
        return maxIndex;
    }

     public VectorB divi(double divider) {
        VectorB result = new VectorB(this.rows);
        for (int i = 0; i < values.length; i++) {
            result.values[i] = values[i] / divider;
        }
        return result;
    }

     public void printVectorB() {
        DecimalFormat df = new DecimalFormat("0.#####");
        for (int i = 0; i < this.rows; i++) {
            System.out.print(df.format(this.values[i]) + " ");
        }
    }

     public int getRows() {
        return rows;
    }

     public double[] getValues() {
        return values;
    }

     public void setRows(int rows) {
        this.rows = rows;
    }

     public void setValues(double[] values) {
        this.values = values;
    }

     public boolean convergence(VectorB vector){
        for (int i = 0; i < vector.rows; i++) {
            if (vector.getValues()[i]-values[i]>0.000001 ) return false;
        }
        return true;
    }
}