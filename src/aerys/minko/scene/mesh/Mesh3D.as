package aerys.minko.scene.mesh
{
	import aerys.minko.effect.basic.BasicStyle3D;
	import aerys.minko.ns.minko;
	import aerys.minko.query.rendering.RenderingQuery;
	import aerys.minko.query.rendering.TransformManager;
	import aerys.minko.scene.AbstractScene3D;
	import aerys.minko.type.stream.IndexStream3D;
	import aerys.minko.type.stream.VertexStream3D;
	import aerys.minko.type.stream.VertexStream3DList;
	import aerys.minko.type.vertex.format.Vertex3DComponent;
	
	public class Mesh3D extends AbstractScene3D implements IMesh3D
	{
		use namespace minko;
		
		private static var _id : uint = 0;
		
		protected var _vertexStreamList	: VertexStream3DList	= null;
		protected var _indexStream		: IndexStream3D			= null;
		
		public function get version() : uint
		{
			return _vertexStreamList.version + _indexStream.version;
		}
		
		public function get vertexStreamList() : VertexStream3DList
		{
			return _vertexStreamList;
		}
		
		public function set vertexStreamList(value : VertexStream3DList) : void
		{
			_vertexStreamList = value;
		}

		public function get indexStream() : IndexStream3D
		{
			return _indexStream;
		}

		public function Mesh3D(vertexStreamList	: VertexStream3DList	= null,
							   indexStream		: IndexStream3D 		= null)
		{
			super();
			
			/*if (null == vertexStreamList.getComponentStream(Vertex3DComponent.XYZ))
				throw new Error('VertexStreamList must contain vertex position component (Vertex3DComponent.XYZ)');*/
			
			_vertexStreamList = vertexStreamList;
			_indexStream = indexStream;
			
			if (!_indexStream && _vertexStreamList)
				_indexStream = IndexStream3D.dummy(vertexStreamList.length, vertexStreamList.dynamic)
		}
		
		override protected function acceptRenderingQuery(query : RenderingQuery) : void
		{
			var transform : TransformManager = query.transform;
			
			query.style.set(BasicStyle3D.WORLD_MATRIX, 				transform.world)
				  	   .set(BasicStyle3D.VIEW_MATRIX, 				transform.view)
				  	   .set(BasicStyle3D.PROJECTION_MATRIX,			transform.projection)
				  	   .set(BasicStyle3D.LOCAL_TO_SCREEN_MATRIX, 	transform.getLocalToScreen());
			
			query.draw(vertexStreamList, indexStream);
		}
		
	}
}