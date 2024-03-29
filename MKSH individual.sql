--SELECT (select SUM(dbo.DATA_HISTORY.UDS_DIA) as AV_ROOMS
--FROM            dbo.GRUPO INNER JOIN
--                         dbo.CLIENT_GRUPOS ON dbo.GRUPO.IDGRUPO = dbo.CLIENT_GRUPOS.IDGRUPO INNER JOIN
--                         dbo.DATA_HISTORY ON dbo.CLIENT_GRUPOS.IDCENTRO = dbo.DATA_HISTORY.RASCLIENTID INNER JOIN
--                         dbo.CLIENTS ON dbo.CLIENT_GRUPOS.IDCENTRO = dbo.CLIENTS.RASCLIENTID 
--GROUP BY dbo.DATA_HISTORY.RASCLIENTID, YEAR(dbo.DATA_HISTORY.FECHA), MONTH(dbo.DATA_HISTORY.FECHA), dbo.CLIENT_GRUPOS.IDGRUPO, dbo.CLIENTS.COMPNAME
--HAVING        (dbo.CLIENT_GRUPOS.IDGRUPO = '1') AND (MONTH(dbo.DATA_HISTORY.FECHA) = '7')AND (YEAR(dbo.DATA_HISTORY.FECHA) = '2015')) AS NUM, (select SUM (UDS_DIA) 
--FROM         dbo.CLIENT_GRUPOS INNER JOIN
--                      dbo.GRUPO ON dbo.CLIENT_GRUPOS.IDGRUPO = dbo.GRUPO.IDGRUPO INNER JOIN
--                      dbo.DATA_HISTORY ON dbo.CLIENT_GRUPOS.IDCENTRO = dbo.DATA_HISTORY.RASCLIENTID
--WHERE     (MONTH(dbo.DATA_HISTORY.FECHA) = '7') AND (YEAR(dbo.DATA_HISTORY.FECHA) = '2015') AND 
--                      (dbo.CLIENT_GRUPOS.IDGRUPO = '1') ) as UDS_DISPONIBLES, (NUM / UDS_DISPONIBLES) AS NUM2


SELECT cast(cast(UDS * 100 AS DECIMAL(10, 2)) / (select SUM (UDS_DIA) 
FROM         dbo.CLIENT_GRUPOS INNER JOIN
                      dbo.GRUPO ON dbo.CLIENT_GRUPOS.IDGRUPO = dbo.GRUPO.IDGRUPO INNER JOIN
                      dbo.DATA_HISTORY ON dbo.CLIENT_GRUPOS.IDCENTRO = dbo.DATA_HISTORY.RASCLIENTID
WHERE     (MONTH(dbo.DATA_HISTORY.FECHA) = '7') AND (YEAR(dbo.DATA_HISTORY.FECHA) = '2015') AND 
                      (dbo.CLIENT_GRUPOS.IDGRUPO = '1') ) AS DECIMAL(10, 2)) AS MKSH
FROM (select SUM(dbo.DATA_HISTORY.UDS_DIA) as UDS
FROM            dbo.GRUPO INNER JOIN
                         dbo.CLIENT_GRUPOS ON dbo.GRUPO.IDGRUPO = dbo.CLIENT_GRUPOS.IDGRUPO INNER JOIN
                         dbo.DATA_HISTORY ON dbo.CLIENT_GRUPOS.IDCENTRO = dbo.DATA_HISTORY.RASCLIENTID INNER JOIN
                         dbo.CLIENTS ON dbo.CLIENT_GRUPOS.IDCENTRO = dbo.CLIENTS.RASCLIENTID 
GROUP BY dbo.DATA_HISTORY.RASCLIENTID, YEAR(dbo.DATA_HISTORY.FECHA), MONTH(dbo.DATA_HISTORY.FECHA), dbo.CLIENT_GRUPOS.IDGRUPO, dbo.CLIENTS.COMPNAME
HAVING        (dbo.CLIENT_GRUPOS.IDGRUPO = '1') AND (MONTH(dbo.DATA_HISTORY.FECHA) = '7')AND (YEAR(dbo.DATA_HISTORY.FECHA) = '2015')) AS UDS


--fair share
SELECT cast(cast(OC_ROOMS * 100 AS DECIMAL(10, 2)) / (SELECT (CAST((select (( select (select SUM (UDS_DIA) 
FROM         dbo.CLIENT_GRUPOS INNER JOIN
                      dbo.GRUPO ON dbo.CLIENT_GRUPOS.IDGRUPO = dbo.GRUPO.IDGRUPO INNER JOIN
                      dbo.DATA_HISTORY ON dbo.CLIENT_GRUPOS.IDCENTRO = dbo.DATA_HISTORY.RASCLIENTID
WHERE     (MONTH(dbo.DATA_HISTORY.FECHA) = '7') AND (YEAR(dbo.DATA_HISTORY.FECHA) = '2015') AND 
                      (dbo.CLIENT_GRUPOS.IDGRUPO = '1')) as UDS_DISPONIBLES) * (SELECT     CAST(AVG(MITO) AS DECIMAL(10, 2)) AS TOGEN
FROM (
select (DATA_HISTORY.TASA_OCUPACION) as MITO from DATA_HISTORY where (MONTH(dbo.DATA_HISTORY.FECHA) = '7') AND (YEAR(dbo.DATA_HISTORY.FECHA) = '2015')
 and DATA_HISTORY.RASCLIENTID in ('70606')   
                                                   UNION ALL 
                                                   SELECT     (dbo.DATA_HISTORY.TASA_OCUPACION) AS TOGEN
FROM         dbo.CLIENT_GRUPOS INNER JOIN
                      dbo.GRUPO ON dbo.CLIENT_GRUPOS.IDGRUPO = dbo.GRUPO.IDGRUPO INNER JOIN
                      dbo.DATA_HISTORY ON dbo.CLIENT_GRUPOS.IDCENTRO = dbo.DATA_HISTORY.RASCLIENTID
WHERE     (MONTH(dbo.DATA_HISTORY.FECHA) = '7') AND (YEAR(dbo.DATA_HISTORY.FECHA) = '2015') AND 
                      (dbo.CLIENT_GRUPOS.IDGRUPO = '1')
) S)/100) as UDS_VENDIDAS)AS DECIMAL(10, 2)))) AS DECIMAL(10, 2)) AS MKSH
FROM (select CAST((SUM(dbo.DATA_HISTORY.UDS_DIA)*CAST(AVG(dbo.DATA_HISTORY.TASA_OCUPACION) AS DECIMAL(10, 2))/100)AS DECIMAL(10, 2)) as OC_ROOMS
FROM            dbo.GRUPO INNER JOIN
                         dbo.CLIENT_GRUPOS ON dbo.GRUPO.IDGRUPO = dbo.CLIENT_GRUPOS.IDGRUPO INNER JOIN
                         dbo.DATA_HISTORY ON dbo.CLIENT_GRUPOS.IDCENTRO = dbo.DATA_HISTORY.RASCLIENTID INNER JOIN
                         dbo.CLIENTS ON dbo.CLIENT_GRUPOS.IDCENTRO = dbo.CLIENTS.RASCLIENTID 
GROUP BY dbo.DATA_HISTORY.RASCLIENTID, YEAR(dbo.DATA_HISTORY.FECHA), MONTH(dbo.DATA_HISTORY.FECHA), dbo.CLIENT_GRUPOS.IDGRUPO, dbo.CLIENTS.COMPNAME
HAVING        (dbo.CLIENT_GRUPOS.IDGRUPO = '1') AND (MONTH(dbo.DATA_HISTORY.FECHA) = '7')AND (YEAR(dbo.DATA_HISTORY.FECHA) = '2015')) AS UDS