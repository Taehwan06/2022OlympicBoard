function replyCntFn(){
	
	
	
		String sql = "select * from (select count(*) c from reply where bidx=?)";
		psmt = conn.prepareStatement(sql);
		psmt.set
		
}