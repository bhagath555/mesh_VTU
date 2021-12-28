# mesh_VTU_matlab
This reposity tries to explain the format of VTU file, and How to write a any geometry information as a VTU file. (Using MATLAB).![multidata2](README/multidata2.png)

Basically, VTU in one of the file format of Visualization toolkit (VTK). It stands for Visualization toolkit of Unstructured_grid. There are other types of Visualization toolkit formats like, structured_points, structured_grid, Ploy_data, and more. Here, I would like to describe the structure of VTU file format in possible detailed manner and implement them in programming languages like MATLAB and Python. This helps in visualizing scientific data in software's like ParaView.

#### The major sections in VTU format are 

* Point information, 
* Cell information,
* Point data section (Data associated with the points).
* Cell data section (Data associated with cells).

Note : While reading the below section, I'll suggest you read any one of the example .vtu to actually observe the VTU structure. And also, geometry and other data used in the example  .vtu is shown pictorially in section:3. Go through those figures to get idea on implementation and adding more features.

#### Complete Structure of VTU format:

* First line should be the xml version.
* VTK file Type and its version. In our case we are using UnstrcturedGrid type and version 0.1.
* Except the point geometries, Any continuous geometry should be defined as piece. We use <piece> to start the geometry and use <\piece> to close the geometry, programmatically.  In order to define the multiple discontinuous geometries, respective geometries and their corresponding data will be defined with in <piece> and </piece> commands. 
* As initializing the piece, It is important to provide the number of points and cells information. 
* Within the Piece, We provide the Point data as shown below. 
  * It should start with <PointData> command.
    * While entering the actual data, We have to define the respective collection of information in DataArray format, this is the case with any kind of collection of information.
    * With in data array, It is necessary to mentions the numerical type of the data, i.e float or int, then data name. The provided data will be available with this name tag in the visualization software's like paraview.
    * then format of the data, whether it is ascii or binary. 
    * And number of components of data at any its corresponding vertex or cell
    * After defining the  information, we provide the components of data of each vertex. 
    * Then we add  <\DataArray> at the end provided array section.
  * While writing the Cell data entire structure is same, but instead of point data, we just replace the PointData with CellData. 
  * Then, we have to add point data. Here, we have start with <Points> and <DataArray> then provide the number of coordinate components it is having. Add all the point data in next line and close the DataArray and Points.
  * After providing the points information, Rest of the section is related to the Cell information.
    * First thing is connectivity, It is nothing but, index of set of point belongs to each cell. After mentioning the data close the data array.
    * Then offset, It is divides the connectivity information into the cells, It values are  range of vertices for each cell.
    * Last one is type of  the cells used for above topology.
  * Yeah, We reached to the end. Here, Close the all opened section above and view the file in Paraview.

Example:



![elems](README/elems.png)

